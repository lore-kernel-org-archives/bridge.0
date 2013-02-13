Return-Path: <davem@davemloft.net>
Date: Wed, 13 Feb 2013 14:08:51 -0500 (EST)
Message-Id: <20130213.140851.2190933816965797127.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1360777309-25522-1-git-send-email-vyasevic@redhat.com>
References: <1360777309-25522-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v10 net-next 00/12] VLAN filtering/VLAN aware
	bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org

From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed, 13 Feb 2013 12:41:37 -0500

> Changes since v9:
> * series re-ordering so make functionality more distinct.  Basic vlan
>   filtering is patches 1-4.  Support for PVID/untagged vlans is patches
>   5 and 6.  VLAN support for FDB/MDB is patches 7-11.  Patch 12 is
>   still additional egress policy.
> * Slight simplification to code that extracts the VID from skb.  Since we
>   now depend on the vlan module, at the time of input skb_tci is guaranteed
>   to be set if the packet had 8021q header.  We can simply refere to it.
> * Changed the opaque 'parent' pointer from prior patches to a union so we
>   can be much more explicit in our assignments.
> * Lots of additional testing with STP turned on.  No issues were observed.

Thanks a lot for keeping this series uptodate Vlad.

Stephen, I think this series is ready, anything needed to be fixed still
can be follow-on patches.  Agreed?

Thanks.
