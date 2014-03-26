Return-Path: <vyasevic@redhat.com>
Message-ID: <5332FBD0.2010802@redhat.com>
Date: Wed, 26 Mar 2014 12:09:52 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1395849627-15711-1-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1395849627-15711-1-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/2] bridge: Fix forwarding of 8021AD frames
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: shemminger@vyatta.com, bridge@lists.linux-foundation.org

On 03/26/2014 12:00 PM, Vlad Yasevich wrote:
> Bridge has its own way to deterine if the packet is forwardable and it doesn't
> support 8021ad tags correctly.  Instead just allow bridge to use an
> existing is_skb_forwardable() function.
> 
> 
> Vlad Yasevich (2):
>   net: Allow modules to use is_skb_forwardable
>   bridge: use is_skb_forwardable in forward path
> 
>  include/linux/netdevice.h | 1 +
>  net/bridge/br_forward.c   | 7 +------
>  net/core/dev.c            | 3 ++-
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 

Self-nack.  Missed one of the hunks in patch2.

-vlad
