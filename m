Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Bridge support unavailable
Date: Wed, 14 Jul 2004 17:37:35 -0500
Message-ID: <D1BBAADDE65D9646B5F0C6332C038B4E06F147@mbgexc.mbgdocs.com>
From: "Bert Hubbs" <bhubbs@mbgdocs.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bruce Ferrell <bferrell@baywinds.org>
Cc: bridge@lists.osdl.org

I don't have a modules.conf. I have modprobe.conf and it has alias
entries for network adapter/driver. I added "alias br0 bridge" but no
change.
During boot something is trying to call the bridge up but it can't find
brctl. Loopback loads then bridge then the three network cards.
This may come as no surprise but I just discovered that even though I
was able to build the bridge, when I performed a ifup br0 I got the same
message I get at boot time.

I'm wondering now if I didn't get brctl installed properly. I never
found definitive installation instruction so I wondering if anyone knows
the installation procedure. Do I do a "configure" then a "make" and then
a "make install" or just "install"?


Bert Hubbs
McGlinchey Stafford and
Youngblood & Bendalin, PLLC
2711 N. Haskell Ave.
Suite 2700, LB 25
Dallas, TX 75204
214-257-1817 (direct dial)
469-235-1817 (mobile)
214-257-1881 (fax)


-----Original Message-----
From: Bruce Ferrell [mailto:bferrell@baywinds.org] 
Sent: Wednesday, July 14, 2004 12:58 AM
To: Stephen Hemminger
Cc: Bert Hubbs; bridge@lists.osdl.org
Subject: Re: [Bridge] Bridge support unavailable

OK Stephen,

I will stipulate the code fragment you've provided is supposed to load 
the bridge.o module... BUT from the previous statements, it doesn't work

that way for Bert.  As I mentioned my compile of the module has all 
those nasty undefined symbol errors so until I get that right all I can 
do is talk about the way other modules work.

Is that fragment from brctl BTW?

Stephen Hemminger wrote:
> On Tue, 13 Jul 2004 13:15:57 -0700
> bferrell@baywinds.org wrote:
> 
> 
>>Stephen,
>>
>>The module will only autoload if /etc/modules.conf is setup for it.
Checking  redhat 7.3, redhat 9.0, WhiteBox EL3, Suse 8.0 and Suse 9.0
systems, none have anything to cause bridge.o to alias to br0.  Those
are the only systems I have to look at.  I don't know what other distros
like debian or mandrake do for bridge.o.  They might have it in the
modules.conf file... Dunno.
>>
> 
> 
> Wrong!  It gets done by:
> 	static int sock_ioctl(struct inode *inode, struct file *file,
unsigned int cmd,
> 		      unsigned long arg)
> {
> 	...
> 	switch(cmd) {
> 	...
> 		case SIOCGIFBR:
> 		case SIOCSIFBR:
> 		case SIOCBRADDBR:
> 		case SIOCBRDELBR:
> 			err = -ENOPKG;
> 			if (!br_ioctl_hook)
> 				request_module("bridge");
> 
> 
> 
>>So, Bert, you'll need to add something like this to /etc/modules.conf:
>>
>>alias br0 bridge
> 
> 
> Don't do that.  It will autoload the bridge, but br0 will not be
created automatically!
> I.e. if the configuration script does:
> 	ifconfig br0 up
> 
> Then it will load the bridge module, but since the bridge hasn't been
created you will
> get "no such device" error.
> 


The information contained in this e-mail message is intended only for the personal and confidential use of the recipient(s) named above. This message may be an attorney-client communication and/or work product and as such is privileged and confidential. If the reader of this message is not the intended recipient or an agent responsible for delivering it to the intended recipient, you are hereby notified that you have received this document in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify us immediately by e-mail, and delete the original message. 

