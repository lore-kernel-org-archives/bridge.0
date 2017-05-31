Return-Path: <forwardinglnx@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=xYziw1idVEaiP5mfR0cRMEpbfNeGPwR/YgKvoLaUZxM=;
	b=ltDmGnAPWD+JPFncgFrReDnoyGEBCsNBMJMhSj0RZVjwNas37qE2NxbGjvUYPGwRPC
	s6O3Fk3Ej+mUAqWFdzb6QpObZbWPOMKvIvHnv0z4aSJoDbURuv04Zd2Bbev2cu6a46sR
	4gLmCOeCB6fVkR/qXyvqK9VA7AI4mshXP0CWw46tMggWJVF7xI/qvfzo8mqVO2/DQnqu
	6hyTOorqp/XBXoHqoZlnhFoA5MEbUQcrHKC2dYXkSu7lcas7ptjZayfEILDGU4Kg6wNf
	WgdrPLnsug/HPuC7b6fbcw8Mw83FDIowIXeW/gTMl29aQlbZQtLWtRcjKM2qjDA8DoB2
	lDSQ==
MIME-Version: 1.0
In-Reply-To: <45967005-7501-6c96-eb95-f83c5f631277@lab.ntt.co.jp>
References: <CA+N+6-xY7+coc6zFqzP665WMhbGFFMHOfre9wNxRAcSF2Bthzw@mail.gmail.com>
	<e6143108-3eb4-6f6a-c58b-857722f706b9@lab.ntt.co.jp>
	<CA+N+6-xtSgQ4eDN7SBMg43WXEc=6quPNE4L1-3xjLuTMte0DSA@mail.gmail.com>
	<fbf9c273-d326-c26e-593f-ccf139bc0049@lab.ntt.co.jp>
	<CA+N+6-wErt=9XX6u8tPnLbb2DrLqADOnCBn3mDe=qvxCoLCFyg@mail.gmail.com>
	<45967005-7501-6c96-eb95-f83c5f631277@lab.ntt.co.jp>
From: Manohar Kumar <forwardinglnx@gmail.com>
Date: Tue, 30 May 2017 18:50:35 -0700
Message-ID: <CA+N+6-xBtWg1+cUeCvdEK1fJbHHVdXpdORWvALosUZtWWG4C8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] Deleting a dynamic mac entry..
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Please see inline..

On Fri, May 26, 2017 at 1:15 AM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> On 2017/05/26 14:08, Manohar Kumar wrote:
>> On Wed, May 24, 2017 at 6:11 PM, Toshiaki Makita
>> <makita.toshiaki@lab.ntt.co.jp> wrote:
>>> On 2017/05/25 3:05, Manohar Kumar wrote:
>>>> Thanks, Toshiaki.
>>>>
>>>> What is the right way to set the default_pvid using the bridge command
>>>> ? I tried this, which fails..
>>>>
>>>> root@net-3:~# ip link set dev vxlan0 name untagged type vlan id 0
>>>> RTNETLINK answers: Operation not supported
>>>> root@net-3:~#
>>>>
>>>> All the interfaces in the bridge are untagged.
>>>
>>> # ip link set br0 down
>>> # echo 0 > /sys/class/net/br0/bridge/default_pvid
>>>
>>
>> I have the bridge inside a network namespace. There is no
>> /sys/class/net entry for the bridge interface inside the namespace.
>>
>> I see online references to this concept of 'tagged' sysfs directories
>> to support namespaces. But its not clear how to access the sysfs
>> entries for a particular namespace.
>
> Did you remount /sys after entering netns?

No, that was the problem. Mounting /sys did the trick. Appreciate your help.

Trying to understanding this better. How is the sysfs tree maintained
per network namespace ? I assume only the /sys/class/net is per
network namespace and the rest of the /sys is shared with the host
namespace ? Also, how does mounting /sys in the network namespace make
the new /sys/class/net tree visible ?

thanks,
Manohar.


> If not, remount /sys or use "ip netns" which automatically do it.
>
>> Is there any other way to set the default_pvid for the bridge
>> interface inside namespace ?
>
> No, as of 3.19.
>
>
> Toshiaki Makita
>
