Message-ID: <dbf855d00512292346se3738cepd434098967bab214@mail.gmail.com>
Date: Thu, 29 Dec 2005 23:46:38 -0800
From: <wandering.womble@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] bug(?) in br_device_event causes kernel panic for 2.6.14
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi there-

I think I have a bug to report :-(

I'm trying to setup up a bridge for use with OpenVPN on my Gentoo box-
resulting in a lot of fiddling and creating/destroying bridges (mostly
to do with me getting things right in gentoos network config scripts.)

What I've noticed is that when I create br0, and try and add eth0, it
says it's already part of a bridge (it isn't - no bridges yet... may
possibly be 'up' as it's listed by ifconfig.)

Everytime I try something like ifconfig eth0 down, I get a kernel panic/lockup.

Copying what I think is useful from the screen:

EIP is at br_device_event+0x94/0x110 [bridge]
...
Process ifconfig (pid 22092, threadinfo:c18e9999 task:c165c600)
Stack: ....(I assume this is ifconfig's stack, and probably not a lot
of interest to the problem...)

Call Trace:
notifier_call_chain
dev_close
dev_change_flags
devinet_ioctl
inet_ioctl
sock_ioctl
do_ioctl
do_page_fault
vfs_ioctl
sys_ioctl
sysenter_past_esp

....
(0)Kernel panic- not syncing: Fatal exception in interrupt

Note- may have some typos, this is actually a PVR box plugged into a
tv- not the easiest to work with ;-)

Hope that's enough info to be useful, feel free to ask for more- so
long as you're willing to guide me in what info you need, and how to
collect it.

Final note: eth0 is a sis900 on-board ethernet device.

Hope someone can tell me how to fix/avoid this one!

Thanks in advance-

Julian

