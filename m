Message-ID: <4AFBE15E.7030300@aixigo.de>
Date: Thu, 12 Nov 2009 11:20:14 +0100
From: Harald Dunkel <harald.dunkel@aixigo.de>
MIME-Version: 1.0
References: <4AF184B7.2070307@aixigo.de>
In-Reply-To: <4AF184B7.2070307@aixigo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge on bonding interface: DHCP replies don't get
	through
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org, bridge@lists.linux-foundation.org

Harald Dunkel wrote:
> Hi folks,
> 
> I would like to run a bridge for kvm on a bonding interface
> (4 * 1Gbit, Intel e1000e). Problem: The DHCPDISCOVER packets
> sent by the guest show up on my dhcp server as expected, but
> the DHCPOFFER sent as a reply doesn't reach the guest behind
> the bridge.
> 

Please mail if I can help to track this down.

In the meantime I have created a bug report on the kernel
tracker for this problem:

	http://bugzilla.kernel.org/show_bug.cgi?id=14586


Many thanx

Harri

