Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=9RpFkc9owL4cCH0rWXhXnCYFteF27w5pK9Y4Webn4Fc=;
	b=mVCNQkC71cGkAqKJBo1fVcvLxVTm+ktqeq6TJUxz8SeT5hlmDXQYaSxFO7Nwf7I8As
	dCWp/tZYlcta4BzDcCmQ2PsegZ9vdkM1GjQoYK9BBnm3aa1M3zOMz88QB7+jqQLgikLI
	/IdsUdPwP8Gsux6QP6hkzyP0fYgYArauzCLRf7V1CGNK8imrSTBVXS3oWL4Ertnr4M4M
	qYgTJyLLDACvcT9YDeXwIXK9SF6Ohv+lGG1lIzNScWcdHIPj7jS8zC0w1eXl00o1kg3M
	UdcbuuptWFWdUK4Clfb7+DwQEgUZJ8v2YF5FiHIalh/uUsHKS6YPgvsY2/hRz6VDILGy
	rrrA==
MIME-Version: 1.0
In-Reply-To: <20171216093520.74b7fafd@xeon-e3>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
	<CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
	<CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
	<20171216093520.74b7fafd@xeon-e3>
From: Adrian P <adrian27oradea@gmail.com>
Date: Sat, 16 Dec 2017 20:14:19 +0200
Message-ID: <CA+k9h3PEQ+MBq4A2a=k-Dgs=e5vGatc6oKQZd3V7iRysipHjMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On Sat, Dec 16, 2017 at 7:35 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Sat, 16 Dec 2017 16:19:03 +0200
> Adrian P <adrian27oradea@gmail.com> wrote:
>
>> Investigating this further, I have noticed that the mac address of the
>> eth0 interface from the cirros VM instance does not appear in the
>> bridge forwarding table, and this explains why everything starts
>> working only when I set ageing time to 0, because in that case all
>> packets are flooded on all ports and the bridge behaves like a hub.
>>
>> So now the question is: why the bridge does not learn the mac address
>> of the eth0 interface from the cirros VM instance? I am able to see
>> the arp request (ARP, Request who-has 10.20.21.1 tell 10.20.21.233)
>> going out from the cirros VM instance on tap interface, so the bridge
>> should learn the mac address and add it to the forwarding table.
>>
>> The reply back to the arp request (Reply 10.20.21.1 is-at
>> 00:17:08:c4:52:80) does not reach the cirros VM instance anymore, and
>> now I know why: there is no mac address in the forwarding table, so
>> the bridge does not know on which port to send the arp reply back.
>>
>> This happens with tap interfaces only. I can see many mac addresses
>> associated with "physical" interface ens160 (that is interface number
>> 1) in the forwarding table, but in case of the tap interfaces, there
>> are only two entries, and both entries shows the mac address of the
>> tap interfaces only:
>
> VMWare does ARP spoofing maybe it consumes the ARP

The flow is like this:

vmware <--> ens160 <--> bridge <--> tap if <--> eth0

So my understanding is that when the arp request goes out on the eth0,
through the tap interface, the bridge should learn the eth0 mac
address and add it to the forwarding table. But this does not happen,
so when the arp reply back comes back, the bridge does not know on
which interface to send the arp reply, and this is why nothing works.

I have another bare metal environment, without vmware, and I still
have this issue.

I suspect this is a bug related to the bridge and the tap interface,
since I see many mac address learned by the bridge on the ens160
interface... or maybe some tap / bridge setting? I have no clue. Where
should I report such issue?
