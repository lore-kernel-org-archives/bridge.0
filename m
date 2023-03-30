Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 391C241F2E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B487341E2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1680173115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJ4kHmOyB5GJCNT97r/CEXr1tfWeNmV/zja7PhdakrM=;
 b=lGerEYp3RodGDGGbu9v46KqIKVUtY8TeLHCWxCyKo+lIj9VCOEqmYXb5Luv5Icdw83
 /Q3ohcVMs8/k4KEjqUfKTm0pm1obz2hYyDJZEGwY4xvSV70Uh8/o0fRR62eoC40mv/Bv
 UEBYsZ9wt18DBWpVrq6PHs0ItsJPyhMLJmMVYdRNaFyf6g5o43qmVx2ExIW9JPB5NAcT
 SXRLeONaXaaxnx6NDDtdppC3NfBaEjMNaKyBR43dlSVVCegyF8RxQYNMsOAzUTzA2au6
 2XuJdBK+c0uj4WiQDcWKQjhPoR9V9sl3rqUkq8GEkpgIesqP2468KV0nJR3pSnsRbAgW
 ihWQ==
Message-ID: <6f0d0f2d-474b-caaf-78a7-289e660c3aa0@blackwall.org>
Date: Thu, 30 Mar 2023 13:45:13 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <87fs9ollmn.fsf@kapio-technology.com>
 <ZCUuMosWbyq1pK8R@shredder> <87mt3u7csh.fsf@kapio-technology.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <87mt3u7csh.fsf@kapio-technology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add
 dynamic FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 30/03/2023 13:29, Hans Schultz wrote:
> On Thu, Mar 30, 2023 at 09:37, Ido Schimmel <idosch@nvidia.com> wrote:
>> On Tue, Mar 28, 2023 at 09:30:08PM +0200, Hans Schultz wrote:
>>>
>>> Sorry, but I have sent you several emails telling you about the problems
>>> I have with running the selftests due to changes in the phy etc. Maybe
>>> you have just not received all those emails?
>>>
>>> Have you checked spamfilters?
>>>
>>> With the kernels now, I cannot even test with the software bridge and
>>> selftests as the compile fails - probably due to changes in uapi headers
>>> compared to what the packages my system uses expects.
>>
>> My spam filters are fine. I saw your emails where you basically said
>> that you are too lazy to setup a VM to test your patches and that your
>> time is more valuable than mine, which is why I should be testing them.
>> Stop making your problems our problems. It's hardly the first time. If
>> you are unable to test your patches, then invest the time in fixing your
>> setup instead of submitting completely broken patches and making it our
>> problem to test and fix them. I refuse to invest time in reviewing /
>> testing / reworking your submissions as long as you insist on doing less
>> than the bare minimum.
>>
>> Good luck
> 
> I never said or indicated that my time is more valuable than yours. I
> have a VM to run these things that some have spent countless hours to
> develop with the right tools etc installed and set up. Fixing that
> system will take quite many hours for me, so I am asking for some simple
> assistance from someone who already has a system running supporting the
> newest kernel.
> 
> Alternatively if there is an open sourced system available that would be
> great.
> 
> As this patch-set is for the community and some companies that would
> like to use it and not for myself, I am asking for some help from the
> community with a task that when someone has the system in place should
> not take more than 15-20 minutes, maybe even less.

I'm sorry but this is absolutely the wrong way to go about this. Your setup's
problems are yours to figure out and fix, if you are going to send *any* future
patches make absolutely sure they build, run and work as intended.
Please do not send any future patches without them being fully tested and, as
Ido mentioned, cover at least the bare minimum for a submission.

Thanks,
 Nik

