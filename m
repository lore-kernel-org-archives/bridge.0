Message-ID: <47F13B20.1080801@artcom.pl>
Date: Mon, 31 Mar 2008 21:27:28 +0200
From: =?UTF-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@artcom.pl>
MIME-Version: 1.0
References: <mailman.7.1206990001.1518.bridge@lists.linux-foundation.org>
In-Reply-To: <mailman.7.1206990001.1518.bridge@lists.linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Digest, Vol 55, Issue 20
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Yes .. rstp is not documented and no any info about this feature.
I wait for this(rstp) but today i find this post...
I need to run stp on vlans... so rstp is needed for this.

i have linux bridge with 200 bridged vlans and vlan stp... is needed in 
this day .. to achive more complex scenarios that today's network is.


bridge-request@lists.linux-foundation.org pisze:
> Send Bridge mailing list submissions to
> 	bridge@lists.linux-foundation.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.linux-foundation.org/mailman/listinfo/bridge
> or, via email, send a message with subject or body 'help' to
> 	bridge-request@lists.linux-foundation.org
>
> You can reach the person managing the list at
> 	bridge-owner@lists.linux-foundation.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bridge digest..."
>
>
> Today's Topics:
>
>    1. Re: Bridge sysfs port_no overflow (Stephen Hemminger)
>    2. Re: RSTP in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary problems (Srinivas M.A.)
>    3. Re: RSTP	in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary	problems (Joakim Tjernlund)
>    4. Re: RSTP in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary problems (Srinivas M.A.)
>    5. Re: RSTP in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary problems (Joakim Tjernlund)
>    6. Re: RSTP in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary problems (Joakim Tjernlund)
>    7. Re: RSTP in
>       http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
>       a=summary problems (Joakim Tjernlund)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 31 Mar 2008 08:42:17 -0700
> From: Stephen Hemminger <shemminger@linux-foundation.org>
> Subject: Re: [Bridge] Bridge sysfs port_no overflow
> To: Osama Abu Elsorour <fobowise@gmail.com>
> Cc: bridge@linux-foundation.org
> Message-ID: <20080331084217.26bd1d7f@extreme>
> Content-Type: text/plain; charset=US-ASCII
>
> On Mon, 31 Mar 2008 09:11:31 +0200
> Osama Abu Elsorour <fobowise@gmail.com> wrote:
>
>   
>> All
>>
>> We are running a setup with a large number of bridge ports that  
>> reaches the 900 ports. After switching to recent kernel and brctl- 
>> utils that uses the sysfs interface, we started noticing that the port  
>> numbers are mis-reported when issues the command:
>> brctl showmacs br1
>> After tracing the code, we found that the problem lies in the sysfs  
>> structure called __fdb_entry. The port_no is declared as a u8 while it  
>> is u16 in the rest of the bridge structure. This causes the port_no to  
>> overflow when the bridge port number exceeds 255.
>>
>> The overflow line is in file br_fdb.c function br_fdb_fillbuf:
>>                          fe->port_no = f->dst->port_no;
>> where left hand port_no is _u8 and right hand is _u16.
>>
>> Even if it is unusual to have this number of ports on a single bridge  
>> it should be changed to the sake of consistency.
>> 	
>> This patch shows the change:
>>
>> @@ -94,7 +94,7 @@ struct __port_info
>> struct __fdb_entry
>> {
>> 	__u8 mac_addr[6];
>> -	__u8 port_no;
>> +	__u16 port_no;
>> 	__u8 is_local;
>> 	__u32 ageing_timer_value;
>> 	__u32 unused;
>>     
>
> The problem is that this changes the size of the binary data structure
> and therefore changes the API. Better to do something with the unused
> field and maintain binary compatibility.
>
> Like this:
>
> --- a/include/linux/if_bridge.h	2008-03-31 08:37:57.000000000 -0700
> +++ b/include/linux/if_bridge.h	2008-03-31 08:39:02.000000000 -0700
> @@ -94,10 +94,11 @@ struct __port_info
>  struct __fdb_entry
>  {
>  	__u8 mac_addr[6];
> -	__u8 port_no;
> +	__u8 old_port_no;
>  	__u8 is_local;
>  	__u32 ageing_timer_value;
> -	__u32 unused;
> +	__u16 port_no;
> +	__u16 unused;
>  };
>  
>  #ifdef __KERNEL__
> --- a/net/bridge/br_fdb.c	2008-03-31 08:39:23.000000000 -0700
> +++ b/net/bridge/br_fdb.c	2008-03-31 08:41:32.000000000 -0700
> @@ -285,6 +285,7 @@ int br_fdb_fillbuf(struct net_bridge *br
>  
>  			/* convert from internal format to API */
>  			memcpy(fe->mac_addr, f->addr.addr, ETH_ALEN);
> +			fe->old_port_no = f->dst->port_no;
>  			fe->port_no = f->dst->port_no;
>  			fe->is_local = f->is_local;
>  			if (!f->is_static)
>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 31 Mar 2008 22:29:55 +0530
> From: "Srinivas M.A." <srinivas.aji@gmail.com>
> Subject: Re: [Bridge] RSTP in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary problems
> To: joakim.tjernlund@transmode.se
> Cc: Bridge@lists.linux-foundation.org
> Message-ID:
> 	<fed120860803310959g7d70a5e6s6f40c4275d14592a@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
>   
>>  So I both get a SEGV and the kernel thinks userspace is running STP, not
>>  ideal.
>>     
>
> Segfault is fixed by this:
>
> diff --git a/log.h b/log.h
> index ce0d94e..2fcdcfb 100644
> --- a/log.h
> +++ b/log.h
> @@ -63,7 +63,7 @@ extern int log_level;
>  #ifdef NO_DAEMON
>
>  #define ERROR(_fmt, _args...) \
> -       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, ##_args)
> +       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, __PRETTY_FUNCTION__, ##_args)
>
>  #else
>  #define ERROR(_fmt, _args...) \
>
>
>   
>>  I really think one should be able to start RSTP with rtspctl too so
>>  one doesn't need /sbin/bridge-stp
>>     
>
> bridge-stp is a way to tell the kernel whether it should run its STP
> or not. This was set up to make it possible for users to run "brctl
> stp <bridge_name> on" without directly being concerned with whether
> kernel STP or userspace STP will be run.
> But that doesn't really happen in practice I guess.
>
> Unfortunately, bridge-stp is run with the kernel holding the RTNL
> lock, so the set of things it can do without causing a hang is
> limited. With the current kernel infrastructure, my preference would
> be to start rstpd from the network init scripts in the system and use
> bridge-stp just to decide whether to enable RSTP or kernel STP for the
> given bridge, perhaps based on a setting in ifcfg-<bridge_name> (in
> Redhat network config).
>
> For more robustness, maybe we need additional kernel infrastructure
> where the daemon can tell the kernel it will handle STP (this can be
> done now by setting stp off and then on when bridge-stp will return
> 0), but where the kernel can also tell (maybe by polling) if the
> daemon quits and fall back to kernel STP in that case.
>
>
> ------------------------------
>
> Message: 3
> Date: Mon, 31 Mar 2008 19:06:14 +0200
> From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Subject: Re: [Bridge] RSTP	in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary	problems
> To: Stephen Hemminger <shemminger@vyatta.com>
> Cc: Bridge@lists.linux-foundation.org
> Message-ID: <1206983174.7589.477.camel@gentoo-jocke.transmode.se>
> Content-Type: text/plain
>
>
> On Mon, 2008-03-31 at 09:06 -0700, Stephen Hemminger wrote:
>   
>> On Sat, 29 Mar 2008 18:10:24 +0100
>> "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se> wrote:
>>
>>     
>>>> -----Original Message-----
>>>> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
>>>> Sent: den 29 mars 2008 17:22
>>>> To: 'Bridge@lists.linux-foundation.org'
>>>> Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary problems
>>>>
>>>> Hi List
>>>>
>>>> I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
>>>> in on my 2.6.23 kernel, but didn't get very far:
>>>>
>>>> Created a bridge, br0, with brctl and added two interfaces.
>>>> started rstpd without args and ran rstpctl
>>>>   rstpctl showbridge br0
>>>> and all I get is
>>>>   CTL_get_bridge_state: Got return code 0, 1003
>>>>   Failed to get bridge state: Err_Bridge_is_down
>>>>
>>>> The br0 i/f is UP amd RUNNING and so is the interfaces I added.
>>>> I probably forgot to do something I suppose, but what?
>>>>
>>>>     Jocke
>>>>         
>>> Never mind, user error on my part.
>>>
>>> I do wonder though if rstpd is production ready or still needs more
>>> testing/fixes?
>>>
>>>    Jocke
>>>       
>> The rstpd stuff isn't widely used, more because of the administration,
>> packaging, startup issues etc. It is kind of a chicken/egg problem, no
>> one uses it so no one reports bugs.The RSTP code library has been
>> around for a long while and doesn't have any known issues.
>>     
>
> I see, what do you think of Srinivas rewrite? I looks
> much cleaner, have you had a chance to test it? 
>
>  Jocke
>
>
> ------------------------------
>
> Message: 4
> Date: Mon, 31 Mar 2008 22:40:02 +0530
> From: "Srinivas M.A." <srinivas.aji@gmail.com>
> Subject: Re: [Bridge] RSTP in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary problems
> To: joakim.tjernlund@transmode.se
> Cc: Bridge@lists.linux-foundation.org
> Message-ID:
> 	<fed120860803311010o54a44f16hf86225c81e5ae837@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
>   
>>  Here is a quick hack to make bridge-stp work at all.
>>  The biggest problem is that rstpd cant start if stdio isn't present.
>>  rstpd needs to properly daemonize.
>>     
>
> Your change should help (for Debian?), but it maybe best to start
> rstpd from the network init scripts, rather than from bridge-stp.
> Also, we should not stop the daemon from bridge-stp if there could be
> multiple bridges.
>
>
> ------------------------------
>
> Message: 5
> Date: Mon, 31 Mar 2008 19:54:38 +0200
> From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
> Subject: Re: [Bridge] RSTP in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary problems
> To: "'Srinivas M.A.'" <srinivas.aji@gmail.com>
> Cc: Bridge@lists.linux-foundation.org
> Message-ID: <039301c89358$49dc0420$dd940c60$@Tjernlund@transmode.se>
> Content-Type: text/plain;	charset="us-ascii"
>
>   
>> -----Original Message-----
>> From: Srinivas M.A. [mailto:srinivas.aji@gmail.com]
>> Sent: den 31 mars 2008 19:00
>> To: joakim.tjernlund@transmode.se
>> Cc: Bridge@lists.linux-foundation.org
>> Subject: Re: [Bridge] RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git; a=summary
>> problems
>>
>>     
>>>  So I both get a SEGV and the kernel thinks userspace is running STP, not
>>>  ideal.
>>>       
>> Segfault is fixed by this:
>>
>> diff --git a/log.h b/log.h
>> index ce0d94e..2fcdcfb 100644
>> --- a/log.h
>> +++ b/log.h
>> @@ -63,7 +63,7 @@ extern int log_level;
>>  #ifdef NO_DAEMON
>>
>>  #define ERROR(_fmt, _args...) \
>> -       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, ##_args)
>> +       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, __PRETTY_FUNCTION__, ##_args)
>>
>>  #else
>>  #define ERROR(_fmt, _args...) \
>>     
>
> Thanks
>
>   
>>     
>>>  I really think one should be able to start RSTP with rtspctl too so
>>>  one doesn't need /sbin/bridge-stp
>>>       
>> bridge-stp is a way to tell the kernel whether it should run its STP
>> or not. This was set up to make it possible for users to run "brctl
>> stp <bridge_name> on" without directly being concerned with whether
>> kernel STP or userspace STP will be run.
>> But that doesn't really happen in practice I guess.
>>
>> Unfortunately, bridge-stp is run with the kernel holding the RTNL
>> lock, so the set of things it can do without causing a hang is
>> limited. With the current kernel infrastructure, my preference would
>> be to start rstpd from the network init scripts in the system and use
>> bridge-stp just to decide whether to enable RSTP or kernel STP for the
>> given bridge, perhaps based on a setting in ifcfg-<bridge_name> (in
>> Redhat network config).
>>     
>
> I don't like the bridge-stp <bridge> start/stop interface. Why
> would bridge-stp know what bridge to run RTSP on? A more natural
> way, IMHO, would to extend brctl with a "rstp on" method. Why
> is there one rstpctl tool and one brctl tool?
>
>   
>> For more robustness, maybe we need additional kernel infrastructure
>> where the daemon can tell the kernel it will handle STP (this can be
>> done now by setting stp off and then on when bridge-stp will return
>> 0), but where the kernel can also tell (maybe by polling) if the
>> daemon quits and fall back to kernel STP in that case.
>>     
>
> Yes, something is needed but I don't know the bride interface so I can't
> really comment on how to do it.
>
>     Jocke
>
>
>
> ------------------------------
>
> Message: 6
> Date: Mon, 31 Mar 2008 19:59:58 +0200
> From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
> Subject: Re: [Bridge] RSTP in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary problems
> To: "'Stephen Hemminger'" <shemminger@vyatta.com>
> Cc: Bridge@lists.linux-foundation.org
> Message-ID: <039601c89359$092744c0$1b75ce40$@Tjernlund@transmode.se>
> Content-Type: text/plain;	charset="us-ascii"
>
>   
>> -----Original Message-----
>> From: Stephen Hemminger [mailto:shemminger@vyatta.com]
>> Sent: den 31 mars 2008 19:09
>> To: joakim.tjernlund@transmode.se
>> Cc: Bridge@lists.linux-foundation.org
>> Subject: Re: [Bridge] RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git; a=summary
>> problems
>>
>> On Mon, 31 Mar 2008 19:06:14 +0200
>> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>>
>>     
>>> On Mon, 2008-03-31 at 09:06 -0700, Stephen Hemminger wrote:
>>>       
>>>> On Sat, 29 Mar 2008 18:10:24 +0100
>>>> "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se> wrote:
>>>>
>>>>         
>>>>>> -----Original Message-----
>>>>>> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
>>>>>> Sent: den 29 mars 2008 17:22
>>>>>> To: 'Bridge@lists.linux-foundation.org'
>>>>>> Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary
>>>>>>             
>> problems
>>     
>>>>>> Hi List
>>>>>>
>>>>>> I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
>>>>>> in on my 2.6.23 kernel, but didn't get very far:
>>>>>>
>>>>>> Created a bridge, br0, with brctl and added two interfaces.
>>>>>> started rstpd without args and ran rstpctl
>>>>>>   rstpctl showbridge br0
>>>>>> and all I get is
>>>>>>   CTL_get_bridge_state: Got return code 0, 1003
>>>>>>   Failed to get bridge state: Err_Bridge_is_down
>>>>>>
>>>>>> The br0 i/f is UP amd RUNNING and so is the interfaces I added.
>>>>>> I probably forgot to do something I suppose, but what?
>>>>>>
>>>>>>     Jocke
>>>>>>             
>>>>> Never mind, user error on my part.
>>>>>
>>>>> I do wonder though if rstpd is production ready or still needs more
>>>>> testing/fixes?
>>>>>
>>>>>    Jocke
>>>>>           
>>>> The rstpd stuff isn't widely used, more because of the administration,
>>>> packaging, startup issues etc. It is kind of a chicken/egg problem, no
>>>> one uses it so no one reports bugs.The RSTP code library has been
>>>> around for a long while and doesn't have any known issues.
>>>>         
>>> I see, what do you think of Srinivas rewrite? I looks
>>> much cleaner, have you had a chance to test it?
>>>       
>> He did most of the original rstp code, just haven't had chance to merge it.
>> Dirty secret, I don't use bridging normally, and have to go out of my way to setup
>> tests so that is part of the reason I don't merge things until they have settled.
>>     
>
> :), maybe you could add a testing branch where the new code could be?
>
> One reason for lack of testing of RSTP is that it is hard to find. The
> bridge homepage just mentions that there is ongoing work w.r.t RSTP
>
>  Jocke
>
>
>
>
> ------------------------------
>
> Message: 7
> Date: Mon, 31 Mar 2008 20:05:19 +0200
> From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
> Subject: Re: [Bridge] RSTP in
> 	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
> 	a=summary problems
> To: "'Srinivas M.A.'" <srinivas.aji@gmail.com>
> Cc: Bridge@lists.linux-foundation.org
> Message-ID: <039901c89359$c8215820$58640860$@Tjernlund@transmode.se>
> Content-Type: text/plain;	charset="us-ascii"
>
>   
>> -----Original Message-----
>> From: Srinivas M.A. [mailto:srinivas.aji@gmail.com]
>> Sent: den 31 mars 2008 19:10
>> To: joakim.tjernlund@transmode.se
>> Cc: Bridge@lists.linux-foundation.org
>> Subject: Re: [Bridge] RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git; a=summary
>> problems
>>
>>     
>>>  Here is a quick hack to make bridge-stp work at all.
>>>  The biggest problem is that rstpd cant start if stdio isn't present.
>>>  rstpd needs to properly daemonize.
>>>       
>> Your change should help (for Debian?), but it maybe best to start
>> rstpd from the network init scripts, rather than from bridge-stp.
>> Also, we should not stop the daemon from bridge-stp if there could be
>> multiple bridges.
>>     
>
> Yes, but I was surprised rstpd just hangs when trying to start it this way.
> Could it be the RTNL lock causing this? Maybe rstpd should daemonize earlier
> to prevent this from happening?
>
>    Jocke
>
>
>
>
> ------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
> End of Bridge Digest, Vol 55, Issue 20
> **************************************
>
>
>   

