Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Bridge support unavailable
Date: Tue, 13 Jul 2004 11:17:51 -0500
Message-ID: <D1BBAADDE65D9646B5F0C6332C038B4E06F143@mbgexc.mbgdocs.com>
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

Yep!
First lsmod I got no bridge. Second lsmod after modprobe bridge I got
bridge listed. So here comes the $35 question. How do you make the
module load at boot?
After Googleing modprobe, lsmod, insmod there seems to be know way to
use modprobe to load modules at boot. I came across discussion to add it
to modprobe.conf but others said this would not cause it to load at
boot. Another mentioned rc.local but I'm not sure that rc.local will
load at the right time. On the other had that may not matter but I'm in
to cleanliness.

Any suggestions?



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
Sent: Monday, July 12, 2004 11:05 PM
To: Bert Hubbs
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] Bridge support unavailable

Bert,

Some init script that is trying to execute brctl and causing your error.

  Finding that script can be... interesting.

One thing you almost certainly want to check is to see if bridge.o is 
being loaded.  Use lsmod as root to see if it's loaded.  If it is 
loaded, then you almost certainly won't need to rebuild the kernel.  If 
you don't see it loaded, try modprobe bridge and re-check with lsmod. 
If it loads, again, no kernel rebuild needed.



Bert Hubbs wrote:
> -->
> 
> So Linux does not have a "PATH" while booting? I have brctl in the
/bin 
> and the /sbin directory.
> 
> I looked at the /etc/init.d/network  script and there is mention of 
> bridges but no direct call to brctl.
> 
> Do you think I would be better of recompiling the Kernel with bridging

> built in?
> 
>  
> 
> Well... You need to determine what script the error is coming from...
> Probably /etc/rc.d/init.d/network (or it could be /etc/init.d/network)
> 
>  
> 
> Bert Hubbs wrote:
>>  " That sounds like you need the full path to brctl in your script."
>>
>>  What script?
>>
>>
>>
>>  Bert Hubbs
>>  McGlinchey Stafford and
>>  Youngblood & Bendalin, PLLC
>>  2711 N. Haskell Ave.
>>  Suite 2700, LB 25
>>  Dallas, TX 75204
>>  214-257-1817 (direct dial)
>>  469-235-1817 (mobile)
>>  214-257-1881 (fax)
>>
>>
>>  -----Original Message-----
>>  From: Bruce Ferrell [mailto:bferrell@baywinds.org]
>>  Sent: Monday, July 05, 2004 9:41 PM
>>  To: Bert Hubbs
>>  Cc: bridge@lists.osdl.org
>>  Subject: Re: [Bridge] Bridge support unavailable
>>
>>  That sounds like you need the full path to brctl in your script.
>>
>>  Which leads me to MY question for the list.  I'm having problem
getting
>>  bridge.o to build correctly on 2.4.25 (linus).  Is this a case where
I'd
>>
>>  be better off with it built static?
>>
>>  Bert Hubbs wrote:
>>
>> >When I start Linux I get an error:
>> >
>> >"Bridge support unavailable: brctl not found".
>> >
>> >And then eth0 - 2 load with no problems. After system is up I can
>>
>>  build
>>
>> >the bridge but it does not survive a reboot. Do I need a startup
>>
>>  script
>>
>> >or should it build from the:
>> >
>> >/etc/init.d/bridge
>> >/etc/sysconfig/network-scripts/ifcfg-bro
>> >/etc/sysconfig/network-scripts/ifcfg-eth0
>> >/etc/sysconfig/network-scripts/ifcfg-eth1
>> >/etc/sysconfig/network-scripts/ifcfg-eth2
>> >
>> >
>> >
>> >I am using Core2
>> >
>> >
>> >
>> >Bert Hubbs
>> >McGlinchey Stafford and
>> >Youngblood & Bendalin, PLLC
>> >2711 N. Haskell Ave.
>> >Suite 2700, LB 25
>> >Dallas, TX 75204
>> >214-257-1817 (direct dial)
>> >469-235-1817 (mobile)
>> >214-257-1881 (fax)
>> >
>> >
>> >
>> >The information contained in this e-mail message is intended only
for
>>
>>  the personal and confidential use of the recipient(s) named above.
This
>>  message may be an attorney-client communication and/or work product
and
>>  as such is privileged and confidential. If the reader of this
message is
>>  not the intended recipient or an agent responsible for delivering it
to
>>  the intended recipient, you are hereby notified that you have
received
>>  this document in error and that any review, dissemination,
distribution,
>>  or copying of this message is strictly prohibited. If you have
received
>>  this communication in error, please notify us immediately by e-mail,
and
>>  delete the original message.
>>
>> >
>> >
>> >
>>
------------------------------------------------------------------------
>>
>> >_______________________________________________
>> >Bridge mailing list
>> >Bridge@lists.osdl.org
>> >http://lists.osdl.org/mailman/listinfo/bridge
>>
>>
>>
>>  The information contained in this e-mail message is intended only
for 
> the personal and confidential use of the recipient(s) named above.
This 
> message may be an attorney-client communication and/or work product
and 
> as such is privileged and confidential. If the reader of this message
is 
> not the intended recipient or an agent responsible for delivering it
to 
> the intended recipient, you are hereby notified that you have received

> this document in error and that any review, dissemination,
distribution, 
> or copying of this message is strictly prohibited. If you have
received 
> this communication in error, please notify us immediately by e-mail,
and 
> delete the original message.
> 
>>
> 
> 
> The information contained in this e-mail message is intended only for 
> the personal and confidential use of the recipient(s) named above.
This 
> message may be an attorney-client communication and/or work product
and 
> as such is privileged and confidential. If the reader of this message
is 
> not the intended recipient or an agent responsible for delivering it
to 
> the intended recipient, you are hereby notified that you have received

> this document in error and that any review, dissemination,
distribution, 
> or copying of this message is strictly prohibited. If you have
received 
> this communication in error, please notify us immediately by e-mail,
and 
> delete the original message.


The information contained in this e-mail message is intended only for the personal and confidential use of the recipient(s) named above. This message may be an attorney-client communication and/or work product and as such is privileged and confidential. If the reader of this message is not the intended recipient or an agent responsible for delivering it to the intended recipient, you are hereby notified that you have received this document in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify us immediately by e-mail, and delete the original message. 

