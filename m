Return-Path: <davem@davemloft.net>
Date: Tue, 29 Jan 2013 16:11:40 -0500 (EST)
Message-Id: <20130129.161140.2166884661210517263.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1359489180-10012-1-git-send-email-vyasevic@redhat.com>
References: <1359489180-10012-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 00/13] Add basic VLAN support to bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com

From: Vlad Yasevich <vyasevic@redhat.com>
Date: Tue, 29 Jan 2013 14:52:47 -0500

> This is another revision of the VLAN filtering patchset.  It offers
> functionality that is similar to what can be found in switches as
> far as VLAN configuration and filtering of frames according to VLAN
> tags.
> 
> Each port on the bridge, as well as the bridge itself, can be configured
> with a set of VLANs that they are willing to accept.  One of the vlans
> may be chosen as PVID and any untagged traffic will be associated with it.

I've done a quick review of this respin and it looks fine as far
as I can tell.

I'd like to apply it soon rather than let it rot in patchwork, so
Stephen if you could give this a once over soon I'd appreciate it.

Thanks.
