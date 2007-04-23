Message-ID: <60386.193.196.136.17.1177336334.squirrel@sleon.dyndns.org>
In-Reply-To: <24321.193.196.136.17.1177322032.squirrel@sleon.dyndns.org>
References: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
	<462B9243.6070804@linux-foundation.org>
	<24321.193.196.136.17.1177322032.squirrel@sleon.dyndns.org>
Date: Mon, 23 Apr 2007 13:52:14 -0000 (UTC)
Subject: Re: [Bridge] linux bridge does not bridge bpdu packets
From: "Roman Glebov" <sleon@sleon.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: sleon@sleon.dyndns.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Hallo
when i disable all lines in net/bridge/br.c which are related to following
lines:

static struct llc_sap *br_stp_sap;
..
        br_stp_sap = llc_sap_open(LLC_SAP_BSPAN, br_stp_rcv);
        if (!br_stp_sap) {
                printk(KERN_ERR "bridge: can't register sap for STP\n");
                return -EADDRINUSE;
        }
...

Will i get as result that all stp packets are passed untouched other the
bridge ?

With regards,
Roman Glebov

>> Roman Glebov wrote:
>>> Hallo,
>>>
>>> i have here transparent linux based bridge.
>>>
>>> The problem is : all stp packets which come to one side of the Bridge
>>> are
>>> not forwarded to the other side. Which distrubs stp when this device is
>>> put inbetween of two stp capable devices.
>>> It forwards all traffik through it.
>>> Normal udp/tcp traffik is forwarded.
>>>
>>> I switched stp on it "off" so it does not participate in Spanning tree
>>> communications.
>>>
>>> It is a very simple setup :
>>> br0 with eth0 and eht1 as ports. without any additional firewall rules.
>>>
>>>
>>> I am using 2.6.18-4-686 debian kernel(testing).
>>>
>>> i even did setfd br0 0.
>>>
>>>
>>> What am i doing wrong ?
>>>
>>> Do i need to use ebtables to explicitely forward the traffic?
>>>
>> Turn on STP in the bridge, it will then receive process and send it's
>> own STP BPDU's.
>>
>>
>
>
> this makes my "stealth" bridge not stealphy anymore!
> because you can see in bptu packets its mac.
>
> That is what i want to prevent.
> I want it to be completely transparent and not seen in the network
> traffic.
>
> So should i patch the kernel for it ?
>
> Roman Glebov
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

