Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 272A260DB2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6A8E60C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43aqpcNIYFz3QzNCa4K6nZo4D8in/o5cheQZTbooLHo=;
 b=C1+7kppzrN6EqgnISDPR9x0DhXRADM+zSxEPPv4xLt/hFSOW8sjFHnyONWAc/3QcTPFvfMw6++AUHIEHeFh3olnzNifJj6SRDC3CnD8pjVY5PlHdcoVvw4IMssjeucKo1fAZORons1LhuhDeWELX+jXuP1s0XS905QzW4gcHo6ePO51JfQgkW7iFYsVQL0XLOISsDbLBAcCBpmmYxK5/FdeSgpUpLsuFkhwIpYv26dgK+EVn+PXPQgCYsfgPteCj+NsvjNi43v4tN2x/yM6ZXA7+ZZSi7qm+j0f27o7l15l/iMXiVumgVPs4bXkaLEXrCmmz7GgP0fPOnwk4OOAEhw==
Date: Tue, 9 Aug 2022 12:20:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YvIm+OvXvxbH6POv@shredder>
References: <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <79683d9cf122e22b66b5da3bbbb0ee1f@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79683d9cf122e22b66b5da3bbbb0ee1f@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Mon, Aug 01, 2022 at 05:33:49PM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-13 14:39, Ido Schimmel wrote:
> 
> > 
> > What are "Storm Prevention" and "zero-DPV" FDB entries?
> > 
> 
> For the zero-DPV entries, I can summarize:
> 
> Since a CPU can become saturated from constant SA Miss Violations from a
> denied source, source MAC address are masked by loading a zero-DPV
> (Destination Port Vector) entry in the ATU. As the address now appears in
> the database it will not cause more Miss Violations. ANY port trying to send
> a frame to this unauthorized address is discarded. Any locked port trying to
> use this unauthorized address has its frames discarded too (as the ports SA
> bit is not set in the ATU entry).

What happens to unlocked ports that have learning enabled and are trying
to use this address as SMAC? AFAICT, at least in the bridge driver, the
locked entry will roam, but will keep the "locked" flag, which is
probably not what we want. Let's see if we can agree on these semantics
for a "locked" entry:

1. It discards packets with matching DMAC, regardless of ingress port. I
read the document [1] you linked to in a different reply and could not
find anything against this approach, so this might be fine or at least
not very significant.

Note that this means that "locked" entries need to be notified to device
drivers so that they will install a matching entry in the HW FDB.

2. It is not refreshed and has ageing enabled. That is, after initial
installation it will be removed by the bridge driver after configured
ageing time unless converted to a regular (unlocked) entry.

I assume this allows you to remove the timer implementation from your
driver and let the bridge driver notify you about the removal of this
entry.

3. With regards to roaming, the entry cannot roam between locked ports
(they need to have learning disabled anyway), but can roam to an
unlocked port, in which case it becomes a regular entry that can roam
and age.

If we agree on these semantics, then I can try to verify that at least
Spectrum can support them (it seems mv88e6xxx can).

P.S. Sorry for the delay, I'm busy with other tasks at the moment.

[1] https://www.cisco.com/c/en/us/td/docs/solutions/Enterprise/Security/TrustSec_1-99/MAB/MAB_Dep_Guide.html#wp392522
