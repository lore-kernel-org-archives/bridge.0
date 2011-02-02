Message-ID: <4D49A87E.4090109@free.fr>
Date: Wed, 02 Feb 2011 19:54:54 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <AANLkTiksJVC7BOM=frcJ1mRzCuUXaqws7F4sH40Xq2iJ@mail.gmail.com>	<4D491494.3060905@free.fr>	<AANLkTimSkgo=qwWmQC845eSHE+XNxE1auwVPMc-ait=s@mail.gmail.com>	<AANLkTi=gObTAvxp+iFHT-q1AbAVf-4bTUNmbEfa_8wof@mail.gmail.com>
	<AANLkTikgstLrscC3JKR7EesgP-hC5G2+CMdEjiwsYCfG@mail.gmail.com>
In-Reply-To: <AANLkTikgstLrscC3JKR7EesgP-hC5G2+CMdEjiwsYCfG@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] vlan interface egress port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sinbad <sinbad.sinbad@gmail.com>
Cc: bridge@osdl.org

Le 02/02/2011 15:46, richardvoigt@gmail.com a écrit :
> On Wed, Feb 2, 2011 at 8:42 AM, richardvoigt@gmail.com
> <richardvoigt@gmail.com>  wrote:
>> It depends on the destination MAC field in the L2 header of the
>> outgoing packet (which got filled in from the kernel routing table)
>
> Actually I should say it gets filled in during the routing process.
> The MAC address actually comes from the ARP table, but which ARP entry
> is used is determined by routing.

1/ Routing will decide which IP is the next hop.
2/ ARP table will convert this IP into a MAC address.
3/ The bridge code will decide which port to use, based on whether it learned this MAC address on 
any port or not. This is the normal behavior of any bridge/switch.

- If the bridge learned this MAC address, it will forward the packet to this port only.
- If the bridge didn't learned this MAC address, it forward the packet to all ports.

To display the currently learned MAC address and associated port, use brctl showmacs <bridge_name>

	Nicolas.
>
>>
>> On Wed, Feb 2, 2011 at 6:04 AM, Sinbad<sinbad.sinbad@gmail.com>  wrote:
>>> hi,
>>>
>>> suppose my config is as below.
>>>
>>>   # brctl addbr mybridge
>>>   # brctl addif mybridge eth0
>>>   # brctl addif mybridge eth1
>>>   # ifconfig mybridge up
>>>   # ifconfig mybridge 192.168.100.5 netmask 255.255.255.0
>>>
>>> now if the an l3 packet has to egress from mybridge
>>> which port will be chosen ?
>>>
>>> thanks
>>>
>>>
>>> On Wed, Feb 2, 2011 at 1:53 PM, Nicolas de Pesloüan
>>> <nicolas.2p.debian@free.fr>  wrote:
>>>>
>>>> Le 02/02/2011 09:02, Sinbad a écrit :
>>>>>
>>>>> hi,
>>>>>
>>>>> suppose a vlan has 3 member ports and vlan is configured as an l3
>>>>> interface
>>>>> and if data is suppose to go out using that vlan interface, which
>>>>> physical port
>>>>> will be chosen among the 3 member ports ?
>>>>
>>>> Can you describe your configuration a little bit more (possibly using the
>>>> commands used to setup that configuration)?
>>>>
>>>>         Nicolas.
>>>
>>>
>>> _______________________________________________
>>> Bridge mailing list
>>> Bridge@lists.linux-foundation.org
>>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>>
>>
>

