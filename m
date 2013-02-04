Return-Path: <vyasevic@redhat.com>
Message-ID: <510FE8BE.4040302@redhat.com>
Date: Mon, 04 Feb 2013 11:58:38 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<20130204082409.422ba135@nehalam.linuxnetplumber.net>
In-Reply-To: <20130204082409.422ba135@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v9 net-next 00/12] Add basic VLAN support to
	bridges
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On 02/04/2013 11:24 AM, Stephen Hemminger wrote:
> One thing I am not clear about is whether is supposed to be just
> a simple filter of VLAN traffic, or a full VLAN aware bridge.

I started with the concept of basic VLAN filtering, but it has been 
morphing into more of a VLAN away bridge.

>
> The change to make FDB entries per-VLAN seems to be the biggest tipping
> point into a full VLAN bridge. I am concerned that might break existing
> API's and Spanning Tree (internal and external).
>

I debated for a while about whether per-VLAN FDB entries were needed. 
The typing point was that without it, you may end up with flopping FDB 
and possible packet drops or vlan leaks, if say 2 different VMs used the 
same MAC but different VLANs.  Without it, there is an exploitable gap.

I've also tried to separate FDB code changes as much as possible.  If 
you really thing this is a big risk and a barrier to entry, then we can 
drop them.  I am just concerned about the hole I described above, but I 
guess it is not much different then what's there now.

Thanks
-vlad
