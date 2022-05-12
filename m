Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652378324;
 bh=kQnu+lsa2BUbB7erRsO6spXf2F1r4I80WSaklHtS+s0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=d9W+LDq884RVoEBnQEgLuNAGooZLGmPR+72DGXjdQVUCU7f9bd4DTzfLYrjZoq7ZP
 vVwuvVQs/mptne1Hs5Tx1tP3aG+zmJBI4tdn6PDJsrGdjQOH2QmIyxQ0XfjPGGj8dJ
 L52GZVxR1y9IRQplwaGlYBGNzOXw+OB4fCPDmqYHMUutjXK006W18FMNBhFzOxEUPQ
 vr8Yemsd1UmPS0jae+L4/PZ9j4wwqrJ/YN0jAxdle6Y5Be85oWM3PiHK2CpaOLyIVh
 mBPDZXavBbf875VBqF/KHGFmtxxCkEIgoY/ct7dfL4MXhVoaxN9FXy0o6KnhC5j001
 Ce7ADn4ZERN+Q==
Date: Thu, 12 May 2022 10:58:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220512105842.68716894@kernel.org>
In-Reply-To: <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
 <20220512094743.79f36d81@kernel.org>
 <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v7 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com

On Thu, 12 May 2022 10:17:13 -0700 Roopa Prabhu wrote:
> On 5/12/22 09:47, Jakub Kicinski wrote:
> > Also the patches don't apply to net-next, again.  
> 
> that's probably because the patches were already applied. Ido just told 
> me abt it also
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5dd6da25255a9d64622c693b99d7668da939a980
> 
> I have requested Alaa send an incremental fix (offline).

Oh, I see, sorry about the confusion.
