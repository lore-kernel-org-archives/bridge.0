MIME-Version: 1.0
In-Reply-To: <AANLkTi=gObTAvxp+iFHT-q1AbAVf-4bTUNmbEfa_8wof@mail.gmail.com>
References: <AANLkTiksJVC7BOM=frcJ1mRzCuUXaqws7F4sH40Xq2iJ@mail.gmail.com>
	<4D491494.3060905@free.fr>
	<AANLkTimSkgo=qwWmQC845eSHE+XNxE1auwVPMc-ait=s@mail.gmail.com>
	<AANLkTi=gObTAvxp+iFHT-q1AbAVf-4bTUNmbEfa_8wof@mail.gmail.com>
Date: Wed, 2 Feb 2011 08:46:17 -0600
Message-ID: <AANLkTikgstLrscC3JKR7EesgP-hC5G2+CMdEjiwsYCfG@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 2, 2011 at 8:42 AM, richardvoigt@gmail.com
<richardvoigt@gmail.com> wrote:
> It depends on the destination MAC field in the L2 header of the
> outgoing packet (which got filled in from the kernel routing table)

Actually I should say it gets filled in during the routing process.
The MAC address actually comes from the ARP table, but which ARP entry
is used is determined by routing.

>
> On Wed, Feb 2, 2011 at 6:04 AM, Sinbad <sinbad.sinbad@gmail.com> wrote:
>> hi,
>>
>> suppose my config is as below.
>>
>> =C2=A0# brctl addbr mybridge
>> =C2=A0# brctl addif mybridge eth0
>> =C2=A0# brctl addif mybridge eth1
>> =C2=A0# ifconfig mybridge up
>> =C2=A0# ifconfig mybridge 192.168.100.5 netmask 255.255.255.0
>>
>> now if the an l3 packet has to egress from mybridge
>> which port will be chosen ?
>>
>> thanks
>>
>>
>> On Wed, Feb 2, 2011 at 1:53 PM, Nicolas de Peslo=C3=BCan
>> <nicolas.2p.debian@free.fr> wrote:
>>>
>>> Le 02/02/2011 09:02, Sinbad a =C3=A9crit :
>>>>
>>>> hi,
>>>>
>>>> suppose a vlan has 3 member ports and vlan is configured as an l3
>>>> interface
>>>> and if data is suppose to go out using that vlan interface, which
>>>> physical port
>>>> will be chosen among the 3 member ports ?
>>>
>>> Can you describe your configuration a little bit more (possibly using t=
he
>>> commands used to setup that configuration)?
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Nicolas.
>>
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
