Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=xn3h02zkEbTThtWG0+VfN08awRfi6E7mE7xgDsdZ/gU=;
	b=M3Fro9wTW6WVk0H/iuBHZP5gyFUYbLH3VNjXnrB6YWX2ihgt8AQPPgp6XOI8lMiuY5
	KocajMecowN9J5CjcW3MflME6kWoDVmYrD23xNYy9WXQoGi6hvWK8wK5EBLfk732sYOu
	nyeDN+zY/OImhJ/5hXWFsTYsHJOPC0v0KqF6BJyaBg78A3M1LFvZ2Tt6JF6TRrt72ykq
	4Bzc+130gShVjXpQFJM9ze0Cw64jcT84XUAAEqViGdSKX68zG+qF/AOGjpoITITWuT6w
	UCoBhtN5f6mzNUJcgq/+CNRIVETpFS02S9sopO6SQB+VTvVNh/48GmXC7fOzwS3cz/hl
	gaCg==
MIME-Version: 1.0
In-Reply-To: <CA+k9h3PEQ+MBq4A2a=k-Dgs=e5vGatc6oKQZd3V7iRysipHjMg@mail.gmail.com>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
	<CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
	<CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
	<20171216093520.74b7fafd@xeon-e3>
	<CA+k9h3PEQ+MBq4A2a=k-Dgs=e5vGatc6oKQZd3V7iRysipHjMg@mail.gmail.com>
From: Adrian P <adrian27oradea@gmail.com>
Date: Sat, 16 Dec 2017 22:01:11 +0200
Message-ID: <CA+k9h3N5+DMFj3jB8s8LinxpzicDwy_jbe42+M7e4ohgt02YxQ@mail.gmail.com>
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

On Sat, Dec 16, 2017 at 8:14 PM, Adrian P <adrian27oradea@gmail.com> wrote:
> On Sat, Dec 16, 2017 at 7:35 PM, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
>> On Sat, 16 Dec 2017 16:19:03 +0200
>> Adrian P <adrian27oradea@gmail.com> wrote:
>>
>>> Investigating this further, I have noticed that the mac address of the
>>> eth0 interface from the cirros VM instance does not appear in the
>>> bridge forwarding table, and this explains why everything starts
>>> working only when I set ageing time to 0, because in that case all
>>> packets are flooded on all ports and the bridge behaves like a hub.
>>>
>>> So now the question is: why the bridge does not learn the mac address
>>> of the eth0 interface from the cirros VM instance? I am able to see
>>> the arp request (ARP, Request who-has 10.20.21.1 tell 10.20.21.233)
>>> going out from the cirros VM instance on tap interface, so the bridge
>>> should learn the mac address and add it to the forwarding table.
>>>
>>> The reply back to the arp request (Reply 10.20.21.1 is-at
>>> 00:17:08:c4:52:80) does not reach the cirros VM instance anymore, and
>>> now I know why: there is no mac address in the forwarding table, so
>>> the bridge does not know on which port to send the arp reply back.
>>>
>>> This happens with tap interfaces only. I can see many mac addresses
>>> associated with "physical" interface ens160 (that is interface number
>>> 1) in the forwarding table, but in case of the tap interfaces, there
>>> are only two entries, and both entries shows the mac address of the
>>> tap interfaces only:
>>
>> VMWare does ARP spoofing maybe it consumes the ARP
>
> The flow is like this:
>
> vmware <--> ens160 <--> bridge <--> tap if <--> eth0
>
> So my understanding is that when the arp request goes out on the eth0,
> through the tap interface, the bridge should learn the eth0 mac
> address and add it to the forwarding table. But this does not happen,
> so when the arp reply back comes back, the bridge does not know on
> which interface to send the arp reply, and this is why nothing works.
>
> I have another bare metal environment, without vmware, and I still
> have this issue.
>
> I suspect this is a bug related to the bridge and the tap interface,
> since I see many mac address learned by the bridge on the ens160
> interface... or maybe some tap / bridge setting? I have no clue. Where
> should I report such issue?

Further investigation reveals something strange: when the
communication starts with an arp request (which happens almost all the
time), the bridge wrongly assigns the eth0 mac address to port 1,
instead of port 3.

Flow again:

default gw --- vmware --- [ ens160 bridge tap ] --- eth0

On my bridge, ens160 is port 1, and the tap interface is port 3. Eth0
mac address is fa:16:3e:9a:04:95

What I have found is that in the forwarding table, the bridge wrongly
assigns the eth0 mac address to the port 1, which is ens160 interface,
instead of assigning it to the port 3, which is the tap interface.
This happens only if the arp table in the cirros VM instance does not
contain the mac address of the destination I am pinging (default gw in
this case), so the cirros VM sends an arp request. See below the eth0
mac address wrongly  assigned in the forwarding table to the port 1:

# brctl showmacs brq025a9a94-58 | grep fa:16:3e:9a:04:95
  1     fa:16:3e:9a:04:95       no                 0.67

However, if I manually add the mac address of the destination IP I am
pining into the cirros VM instance arp table, and there is no arp
request sent, just icmp packets going out, then the bridge correctly
assigns the eth0 mac address to the port 3, which is the tap
interface, and everything starts working fine. See below the eth0 mac
address correctly assigned in the forwarding table to the port 3:

# brctl showmacs brq025a9a94-58 | grep fa:16:3e:9a:04:95
  3     fa:16:3e:9a:04:95       no                 9.26
