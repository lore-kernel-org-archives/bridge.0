Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz9E4BnLE1LViKBc5cRkLR5qPkf7ZyUPc+9hQi8yhS0=;
 b=CroxyoyCfSGcJ5n3d00CfSYNGAWGap8mxVFqTzEGniX5k9DduGCtZvjZxfpAuB9gfhJi2FluUZh295qd8RKTmU/IK/n52rSkF60DaYQHA3iurB748ZOaPNuuFS1o5tqpByEcrIrUfsrQzgFbCz9LmbFJSpgBi37OuWXoI2UjcZU=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
 <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <879c5144-183f-51d3-21e3-51c20d1d02b4@televic.com>
Date: Mon, 27 Jan 2020 15:41:13 +0100
In-Reply-To: <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 06/10] net: bridge: mrp: switchdev:
 Extend switchdev API to offload MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>, Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 1/27/20 12:04 PM, Allan W. Nielsen wrote:
> CAUTION: This Email originated from outside Televic. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On 26.01.2020 16:59, Andrew Lunn wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Sun, Jan 26, 2020 at 02:22:13PM +0100, Horatiu Vultur wrote:
>>> The 01/25/2020 17:35, Andrew Lunn wrote:
>>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>> >
>>> > > SWITCHDEV_OBJ_ID_RING_TEST_MRP: This is used when to start/stop sending
>>> > >   MRP_Test frames on the mrp ring ports. This is called only on nodes that have
>>> > >   the role Media Redundancy Manager.
>>> >
>>> > How do you handle the 'headless chicken' scenario? User space tells
>>> > the port to start sending MRP_Test frames. It then dies. The hardware
>>> > continues sending these messages, and the neighbours thinks everything
>>> > is O.K, but in reality the state machine is dead, and when the ring
>>> > breaks, the daemon is not there to fix it?
> I agree, we need to find a solution to this issue.
>
>>> > And it is not just the daemon that could die. The kernel could opps or
>>> > deadlock, etc.
>>> >
>>> > For a robust design, it seems like SWITCHDEV_OBJ_ID_RING_TEST_MRP
>>> > should mean: start sending MRP_Test frames for the next X seconds, and
>>> > then stop. And the request is repeated every X-1 seconds.
> Sounds like a good idea to me.

Indeed, and it should then do the same as mentioned below and "... come a 'dumb switch' ", except that I propose to make it configurable how to fallback: with auto-recovery ('dumb switch') or safe mode that keeps the ports blocked, and then some higher layer protocol should fix it.

>
>>> I totally missed this case, I will update this as you suggest.
>>
>> What does your hardware actually provide?
>>
>> Given the design of the protocol, if the hardware decides the OS etc
>> is dead, it should stop sending MRP_TEST frames and unblock the ports.
>> If then becomes a 'dumb switch', and for a short time there will be a
>> broadcast storm. Hopefully one of the other nodes will then take over
>> the role and block a port.
> As far as I know, the only feature HW has to prevent this is a
> watch-dog timer. Which will reset the entire system (not a bad idea if
> the kernel has dead-locked).
Indeed. Our designs always have a watchdog.

And then I again propose to have 2 bootup options.

I refer here also to my answer on Allan's answer on my email of 12:29PM.

Kind regards,

Jürgen

>
> /Allan
>

