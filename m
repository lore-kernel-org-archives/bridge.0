Message-ID: <27034.63.87.1.243.1105474752.squirrel@randomparity.com>
Date: Tue, 11 Jan 2005 12:19:12 -0800 (PST)
Subject: Re: [Bridge] Re: tg3 bridge problems
From: <dave@randomparity.com>
In-Reply-To: <20050111140704.GE10074@thunderchild.debian.net>
References: <20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<1105416406.4923.8.camel@localhost.localdomain>
	<20050111085216.GA10074@thunderchild.debian.net>
	<41E3C868.5040605@redhat.com>
	<20050111125831.GD10074@thunderchild.debian.net>
	<41E3D0AB.6060608@redhat.com>
	<20050111140704.GE10074@thunderchild.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: gorgo@broadband.hu
Cc: linux-net@vger.kernel.org, nhorman@redhat.com, bridge@lists.osdl.org

Greg,

My understanding was that the x346 provides remote management support
through an integrated IPMI system management processor (according to the
x346 data sheet).  I also know that the Broadcom controllers provide IPMI
management support through firmware which runs on the controller.  Perhaps
the problem is that the IPMI firmware is resetting promiscuous mode on the
MAC underneath the driver after the hardware reset occurs.

Does the x346 provide any mechanisms to disable the IPMI system management
processor (perhaps a BIOS setup option)?  Does the problem go away when
you do so?

Dave

> On Tue, Jan 11, 2005 at 08:12:11AM -0500, Neil Horman wrote:
>> Gergely Madarasz wrote:
>> >On Tue, Jan 11, 2005 at 07:36:56AM -0500, Neil Horman wrote:
>> >
>> >>You know, there is a tg3_dump_state function that if 0-ed out at the
>>  moment, which among other things dumps out the chips RX_MODE.  You
>> could  uncomment that function and tie it to a private ioctl which
>> you could  call from user space.  That way you could compare the
>> RX_MODE values in  a working and a failing environment. If they
>> matched, you could be  reasonably sure it was a hardware issue,
>> otherwise, you would know your  looking for a driver bug.
>> >
>> >
>> >It seems they do not match:
>> >failing: MAC_RX_MODE[00000002]
>> >working: MAC_RX_MODE[00000102]
>> >
>> >So this would point to a driver bug. To search for that, I added a
>> printk at each write to MAC_RX_MODE to see what is being set up.
>> Every call was fine, the last always being 0x102. Would it be
>> possible that the buggy hardware itself resets this register after a
>> link change or something?
>> >
>> >The following workaround patch made the problem disappear:
>> >
>> >--- tg3.c~      2005-01-11 12:30:21.000000000 +0100
>> >+++ tg3.c       2005-01-11 12:30:21.000000000 +0100
>> >@@ -2803,6 +2803,8 @@
>> >			sblk->status = SD_STATUS_UPDATED |
>> >				(sblk->status & ~SD_STATUS_LINK_CHG);
>> >			tg3_setup_phy(tp, 0);
>> >+			tw32_f(MAC_RX_MODE, tp->rx_mode);
>> >+			udelay(10);
>> >		}
>> >	}
>> >
>> >
>> >So if I reset the rx_mode after the card has reported a link change,
>> promisc works fine. This workaround works on both machines, one
>> having rev 4001 cards, the other having rev 2003's.
>> >
>> >Greg
>>
>> I do believe that tg3 driven chips reset the promisc. bit on chip
>> reset,  so it may be possible that you have found a driver bug in
>> which the  appropriate promiscuous state isn't restored after a reset.
>>  Try adding  a printk to tg3_reset to see if it gets called after you
>> follow your  non-working procedure, and check to see if the promisc
>> bit in
>> MAC_RX_MODE gets lost.  If so, I'd say thats arguably your bug.
>
> I have now added quite a lot of debugging printk's to tg3.c.
> Here is what I see:
>
> eth2: tg3.c(tg3_reset_hw,4946) MAC_RX_MODE: 0006
> eth2: tg3.c(tg3_chip_reset,3786) MAC_RX_MODE: 0006
> eth2: tg3.c(tg3_chip_reset,3948) MAC_RX_MODE: 0000
> eth2: tg3.c(tg3_reset_hw,5413) MAC_RX_MODE: 0002
> eth2: tg3.c(tg3_reset_hw,5436) MAC_RX_MODE: 0002
> eth2: tg3.c(tg3_setup_phy,2434) MAC_RX_MODE: 0002
> eth2: tg3.c(tg3_phy_reset,810) MAC_RX_MODE: 0002
> eth2: tg3.c(tg3_phy_reset,868) MAC_RX_MODE: 0002
> eth2: tg3.c(tg3_setup_phy,2464) MAC_RX_MODE: 0002
> eth2: tg3.c(__tg3_set_rx_mode,6320) MAC_RX_MODE: 0102
> eth2: tg3.c(tg3_reset_hw,5530) MAC_RX_MODE: 0102
> eth2: tg3.c(tg3_poll,2816) MAC_RX_MODE: 0002
>
> that is the promisc bit is lost after leaving tg3_reset_hw, and before
> entering tg3_poll.
>
> Greg


