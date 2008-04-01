Message-ID: <47F24943.3050307@linux-foundation.org>
Date: Tue, 01 Apr 2008 07:40:03 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
References: <8571495929364495836@unknownmsgid>	<7423344835968003573@unknownmsgid>	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>	<1206949458.7589.447.camel@gentoo-jocke.transmode.se>	<fed120860803310959g7d70a5e6s6f40c4275d14592a@mail.gmail.com>	<-2617425004832712825@unknownmsgid>	<fed120860803311309x68edff7cie8e5290133f9a011@mail.gmail.com>	<1207033045.7589.485.camel@gentoo-jocke.transmode.se>	<fed120860804010257h3aa9ab3etafa3d5c2e3db30dd@mail.gmail.com>
	<1207049456.9675.37.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1207049456.9675.37.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge]
 RSTP	in	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
 a=summary	problems
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

Joakim Tjernlund wrote:
> On Tue, 2008-04-01 at 15:27 +0530, Srinivas M.A. wrote:
>   
>>>  Curious, why is RSTP in user space? Lots of protocols are in the kernel,
>>>  why not RSTP too?
>>>       
>> For one thing it is easier from a development standpoint. The kernel
>> just needs to provide hooks for allowing userspace programs to send
>> and receive BPDUs and to change port states. The STP logic can then be
>> moved to userspace and it is easier to develop and debug.
>>     
>
> Yes, but this cannot the only reason to move xSTP to user space? I bet
> that is true for lots of stuff currently in kernel, i.e one could move
> ARP to user space too. You can probably get better performance with
> an in kernel xSTP and possible more robust as you don't depend on a
> external process that could get killed by OOM or by user mistake.
>
>   
>>>  Are any known issues with the in kernel STP?
>>>
>>>  I haven't read 802.1D-2004 but I know RSTP is in there, does RSTP
>>>  replace the old STP protocol? If not, is there any reason to prefer STP
>>>  before RSTP in some cases?
>>>       
>> In 802.1D-2004, RSTP replaces the old STP. RSTP provides additional
>> mechanisms to give faster convergence when the network involves only
>> point-to-point links. It is backward compatible with STP, i.e., it
>> will interoperate correctly when there are other STP bridges, though
>> you lose the fast convergence then. So, in general, there is no reason
>> to prefer STP to RSTP. Currently, the main reason would be that the
>> STP implementation has been around much longer and that this RSTP
>> implementation is new.
>>     
>
> Thanks you for the info, much appreciated. I guess the reason why
> in kernel STP hasn't been converted to RSTP is the user space approach? 
>
> Sorry for all the questions/criticism, this is all fairly new to me and
> I wanted share my initial feelings about RSTP and how it works. Once I
> get used to how it all works I generally stop asking myself why/how
> things work and just get on with it.
>
>  Jocke
>
> PS.
>     I really think you need publish the RSTP work somewhere on the bride
>     home page, I had a hard time finding this and I am sure others too
>     have problems finding it. 
>   

There are several motivations for moving it to user space:
  1. As a userspace application it is less vulnerable to being used for 
remote exploits.  Buffer overflows etc
      in kernel are more damaging.
  2. Rstplib is pre-existing code, and can be incorporated easier into 
user application
  3. The real reason is that there are many flavors of STP and and 
configuration and research are more
      easily managed in userspace.

Note: performance is not an issue for STP.

But:
   1. Robustness is harder in userspace
   2. Close coupling of kernel and daemons is maintance pain
   3. Backwards compatibility problems.

Maybe RSTP in userspace is a bad idea, it is possible to go back.
 
