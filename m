In-Reply-To: <20061213100753.4fc7ed59@dxpl.pdx.osdl.net>
References: <bae22be11b2e93ffe2c4c4cc5e25d9a3@shee.org>
	<20061213100753.4fc7ed59@dxpl.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aa502292d1f9e262608428897c7bfcd5@shee.org>
Content-Transfer-Encoding: 7bit
From: Moire <sec@shee.org>
Date: Sun, 17 Dec 2006 12:39:55 +0100
Subject: Re: [Bridge] Dead loop: "bridge ended up including itself"
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

On 13.12.2006 Stephen Hemminger wrote:

> On Tue, 12 Dec 2006 Moire <sec@shee.org> wrote:
>
>> ...
>> Scenario:
>>
>> Every now and then i get this urgent warning:
>>
>> 1 Time(s): Dead loop on virtual device br0, fix it urgently!
>>
>> Stephen Hemminger wrote (16.08.2006 20:09) this:
>>> It looks like a bridge ended up including itself some how.
>>
>> Its for me unclear when this happens and what trigger this.
>>
>> I would appreciate any info to some resources. For example
>> a technical document covering this issue or similar.
>>
>> My setup is a kernel 2.4.31 with bridge-utils 1.0.4. The box
>> have three network interfaces eth[0-2]. Bridged interfaces
>> are eth[1-2] (router,dmz), eth0 is my intranet.
>> I use DLINK network cards with sk98lin driver.
>
> Could it be the fact that sk98lin driver has some code in it that
> sends spanning tree packets itself!  This crap is because the driver
> has some vendor specific code to do failover on the dual port versions
> of the driver.  Since SysKonnect was big in the FDDI world, I suspect
> they wanted the same management features in their gigabit cards.
>
> You have some choices:
> 1) use a different card
> 2) comment out the code in the sk98lin driver that generates and 
> receives
>    the management frames
> 3) use 2.6 and the skge driver that works on the same hardware.
> 4) backport the skge driver to 2.4.

Hello,

thanks for your reply. I noticed that you provide a backport of the
skge driver. I will test it and do report if it is successful. I hope
that it is possible to build it into the kernel because i don't use
a modularized kernel.

Thanks

C. Moire

