Message-ID: <404384BC.2010402@wp.pl>
Date: Mon, 01 Mar 2004 19:45:16 +0100
From: Software Team <software-team@wp.pl>
MIME-Version: 1.0
Subject: [Bridge] i need some help with compiling bridge module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On ?, 2004-03-01 at 10:31, Software-team wrote:
 > I am trying to improve bridge module towards 802.1w (RSTP) but I am 
new to kernel and modules programming. I dont want to compile the whole 
modules every time I make some changes. Could you give me some clues how 
to set up environment to compile only selected module (bridge 802.1d) 
for a given kernel version, written in Makefile like:
 > VERSION = 2
 > PATCHLEVEL = 4
 > SUBLEVEL = 20
 > EXTRAVERSION =-8 etc.
 > How to make a Makefile so the bridge module could be compiled 
separately for that kernel (or another)?
 > Thanks for any specyfic help.

It's pretty easy. do make menuconfig, and under Networking Options put
'M' where it says 802.1d Ethernet Bridging.

Save your config, and then do make dep && make bzImage modules
modules_install
Move the /usr/src/linux/arch/i386/boot/bzImage to somewhere in /boot
(renaming it if you like), make the appropriate modification to
lilo.conf (and then rerun lilo) or change /boot/grub/grub.conf and
reboot. When it starts up again, just modprobe bridge.

I also found that I had to do make mrproper before I could get the
bridge module to load. In this case, make sure you save your .config
file to somewhere else first, or you'll lose it.

HTH.
-----------------------------------------------

Yes,
What you wrote is sure both right, and simple. But it takes a lot of 
time. But that is not what I want. I want to compile a bridge module 
separately, like you compile some modules that come you add later to 
your kernel (like i did for example with a NTFS module, which I 
downloaded and compilet separately from my kernel 2.4.20-8). I would 
like to do the same with Bridge module. I want to make some changes and 
compile it with kernel headers from my kernel. But I dont want to 
compile the whole kernel (ang go through that process you described) 
every time I make some minor changes to the module which uses the same 
kernel header files. There should be some way to do it, I sure. But I 
dont know how:( I can bet this, because nobody would write kernel if he 
should compile it every time one makes some change. This would take ages 
to finish the project.
Still hoping for an answer.

Software Team

