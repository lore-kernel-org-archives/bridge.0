Message-ID: <20070928103837.gvdex50ucksc4kg0@webapps>
Date: Fri, 28 Sep 2007 10:38:37 -0400
From: "Mark S. Mathews" <mark@linux-wlan.com>
Subject: Re: [Bridge] Flushing MAC-tables(?)
References: <46FCB3F4.4080802@googlemail.com>
	<46FCBC98.6030507@sysnetsistemi.it> <46FCEF57.4080007@googlemail.com>
In-Reply-To: <46FCEF57.4080007@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

There's a simpler solution: at association-time the wlan stack should  
emit (up to linux) a bcast frame w/ the source address of the  
associating station.  That frame will serve to notify the local and  
remote bridges of the move.

-Mark

Quoting Dennis Borgmann <dennis.borgmann@googlemail.com>:

> Hi Francesco,
>
> I already tried playing around with the ageing timer, but it did not
> help me.
>
> Since I am using Kernel 2.4: is there no way of flushing the FDB?
>
> Thanks so far,
> Dennis
>
>
> Francesco Dolcini schrieb:
>> Dennis Borgmann wrote:
>>> So at a certain point of time, there seems to be a flushing of some
>>> bridge-tables, but I don't know, how I could influence this behaviour.
>>> Is this "flushing" somehow to be done manually? Or is there a timer,
>>> which sets this behaviour?
>> in recent kernel (not in 2.4, and maybe only in recent 2.6) you can
>> flush the FDB using sysfs:
>> /sys/class/net/%s/bridge/flush (whole bridge)
>> /sys/class/net/%s/brif/%s/flush (single interface)
>>
>> If you want you can lower the ageing timer from the default 300sec
>> using brcl setageing
>>
>> Maybe you can just force your phone to register more frequently so the
>> bridge will just learn the new port when you move.
>>
>> Francesco
>>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
>



Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286


