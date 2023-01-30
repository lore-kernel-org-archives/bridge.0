Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1488840A87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F2BB40A81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Yav8TprwPE5vEOX+8fXpawYIpntoyZathbapLHXgI=;
 b=fcz0CUAol+7tpmxZN7shACqj2vW3N2hWoguALnJ+7adiFqeJ0tQWWUjQtUF1cbAmDsh18BokJcnkDXPzK6iEbfxWfmqr1qIEBSCYyBPOe1iiIdY6O9W+vcB4EbAOrShoKS4XSyFVuAhuvKnFCNTOFxjIoulfi/PVgq9dM6weUk6GEJR1UdGl3SmMaDJriPmsUG/s5Pt+DkFtS5o83C56Cje+1WSs1FydX0OS5IS2aaE7r2iFNUfHEiew9qi3bz/5GHTX/h9thXHucyrlZ/ucEI/k37nCNXMNiESgAFNZ07kX2N8PABGElUJZGLH6rCpTq5yWWC6ZH0dFq7TTff7t6Q==
References: <cover.1674752051.git.petrm@nvidia.com>
 <1dcd4638d78c469eaa2f528de1f69b098222876f.1674752051.git.petrm@nvidia.com>
 <81821548-4839-e7ba-37b0-92966beb7930@blackwall.org>
From: Petr Machata <petrm@nvidia.com>
Date: Mon, 30 Jan 2023 16:02:07 +0100
In-Reply-To: <81821548-4839-e7ba-37b0-92966beb7930@blackwall.org>
Message-ID: <87r0vcf2w9.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 07/16] net: bridge: Maintain number of
 MDB entries in net_bridge_mcast_port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 26/01/2023 19:01, Petr Machata wrote:
>> Note that the per-port-VLAN mcast_max_groups value gets reset when VLAN
>> snooping is enabled. The reason for this is that while VLAN snooping is
>> disabled, permanent entries can be added above the limit imposed by the
>> configured maximum. Under those circumstances, whatever caused the VLAN
>> context enablement, would need to be rolled back, adding a fair amount of
>> code that would be rarely hit and tricky to maintain. At the same time,
>> the feature that this would enable is IMHO not interesting: I posit that
>> the usefulness of keeping mcast_max_groups intact across
>> mcast_vlan_snooping toggles is marginal at best.
>> 
>
> Hmm, I keep thinking about this one and I don't completely agree. It
> would be more user-friendly if the max count doesn't get reset when
> mcast snooping is toggled. Imposing order of operations (first enable
> snooping, then config max entries) isn't necessary and it makes sense
> for someone to first set the limit and then enable vlan snooping.

If you are talking about mcast_snooping, that can be disabled while
mcast_vlan_snooping is enabled. So you can configure everything, then
turn snooping on.

If you are talking about configuring max while mcast_vlan_snooping is
off, then I assumed one shouldn't touch the VLAN context if
br_multicast_port_ctx_vlan_disabled(). So we would need to track the n
and max in some other entity than in the multicast context. But maybe
I'm wrong.

> Also it would be consistent with port max entries, I'd prefer if we
> have the same behaviour for port and vlan pmctxs. If we allow to set
> any maximum at any time we don't need to rollback anything, also we
> already always lookup vlans in br_multicast_port_vid_to_port_ctx() to
> check if snooping is enabled so we can keep the count correct
> regardless, the same as it's done for the ports. Keeping both limits
> with consistent semantics seems better to me.

The idea of requiring max >= current felt so natural to me that I didn't
even check what mcast_hash_max was doing. Sure -- let's be consistent.
This will incidentally make all the rollbacks go away, and happily makes
sense WRT locking, too: since the relation between max and n is somewhat
loose, we don't need to worry too much about sequencing inc-/dec-n vs.
set-max.
