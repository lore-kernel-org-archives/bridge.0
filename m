Return-Path: <marek@piasta.pl>
Date: Thu, 22 Aug 2013 23:49:41 +0200
From: Marek Kierdelewicz <marek@piasta.pl>
Message-ID: <20130822234941.4affc863@catus>
In-Reply-To: <20130822224453.ca93782f.skraw@ithnet.com>
References: <20130822224453.ca93782f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Can linux kernel bridge forward 802.1q tagged vlan
 packets?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hi,

>My general idea is to bridge tagged vlan packets from a physical
>interface (intel) to a virtual interface (virtio in qemu) and not
>losing the tags, so the qemu guest can use vconfig and friends to get
>some vlan interfaces. Is this possible and are there any additional
>steps necessary besides the usual bridge configuration?

I'm using this setup with KVM virtualization (Qemu's successor). It
didn't work with default nic type for guest (realtek I think) as 802.1q
tags were not preserved properly in one of the directions. I don't
remember specifics. Anyway using e1000 driver instead of default fixed
it. Works like a charm.

Best regards,
Marek Kierdelewicz
