Return-Path: <sandeepacs@tataelxsi.co.in>
Message-ID: <50F4E502.2070102@tataelxsi.co.in>
From: Sandeepa C S <sandeepacs@tataelxsi.co.in>
MIME-Version: 1.0
References: <50F3D5FD.6090608@tataelxsi.co.in>
	<CAJ4ZP5T3nw+E+NP_eDZBCt=gqyiviuUoMEjm=7FuWTCDJhBEmQ@mail.gmail.com>
	<50F41CB1.3040909@redhat.com>
In-Reply-To: <50F41CB1.3040909@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Information needed on the kernel version which
	supports ----
Reply-To: sandeepacs@tataelxsi.co.in
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 15 Jan 2013 05:27:07 -0000
To: vyasevic@redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, stephen@redhat.com, bridge@lists.linux-foundation.org, Balaji Foss <balajig.foss@gmail.com>, shmulik.ladkani@gmail.com, shemminger@vyatta.com, davem@davemloft.net

Hi,

Even i could not find the changed files.
Could you please share if the changed files are available with you.

Thanks and Regards,
Sandeepa CS.


Vlad Yasevich wrote:
> On 01/14/2013 06:35 AM, Balaji Foss wrote:
>>   >1) On what kernel version the VLAN support for multicast groups is
>> being
>>> done
>> Its currently in the net-next tree which would become 3.8
>
> I did not see any "Applied" messages from upstream, so I doubt its in
> any tree yet.  The code is still in development.
>
> -vlad
>
>>
>>> 2)On what flavors it is supported, is it available with Debian
>>
>> If you want to test those changes right away, you will have to do a git
>> clone of the net-next repo and test those patches, else wait for the
>> distributions to package the 3.8 kernel.
>>
>>> 3)How can we get/download the supported patch files for reference.
>> you will have to make a clone of the net-next repo. For more information=

>> look up tutorials on git.
>>
>> Cheers,
>>    - Balaji
>>
>> On Mon, Jan 14, 2013 at 3:25 PM, Sandeepa C S
>> <sandeepacs@tataelxsi.co.in>wrote:
>>
>>> Dear All,
>>>
>>> We are trying to add vlan support for the IGMP snooping feature in the
>>> kernel version 2.6.39
>>> But from the below thread discussion we understood that vlan support is=

>>> already in the bridge.
>>> http://www.spinics.net/lists/**netdev/msg221800.html<http://www.spinics=
.net/lists/netdev/msg221800.html>
>>>
>>>
>>> Could you please let us know the below informations,
>>> 1) On what kernel version the VLAN support for multicast groups is
>>> being
>>> done
>>> 2)On what flavors it is supported, is it available with Debian
>>> 3)How can we get/download the supported patch files for reference.
>>>
>>> --
>>> Thanks & Regards,
>>> Sandeepa cs.
>>>
>>> Notice: The information contained in this e-mail message and/or
>>> attachments to it may contain confidential or privileged
>>> information. If
>>> you are not the intended recipient, any dissemination, use, review,
>>> distribution, printing or copying of the information contained in this
>>> e-mail message and/or attachments to it are strictly prohibited. If you=

>>> have received this communication in error, please notify us by reply
>>> e-mail
>>> or telephone and immediately and permanently delete the message and any=

>>> attachments. Thank you
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at
>>> http://vger.kernel.org/**majordomo-info.html<http://vger.kernel.org/maj=
ordomo-info.html>
>>>
>>>
>>
>
>
> .
>


--
 Thanks & Regards,
 Sandeepa cs.

Notice: The information contained in this e-mail message and/or attachments=
 to it may contain confidential or privileged information. If you are not t=
he intended recipient, any dissemination, use, review, distribution, printi=
ng or copying of the information contained in this e-mail message and/or at=
tachments to it are strictly prohibited. If you have received this communic=
ation in error, please notify us by reply e-mail or telephone and immediate=
ly and permanently delete the message and any attachments. Thank you


