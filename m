Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1585757569; x=1617293569;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n6C6hGBt5easzcPDAonxCbcAUHLA4USUKvAikSy4B+U=;
 b=iHR6vRsHItAQnoqy8H+nffFUS8D6c7Fh0RGqK1NwaXTQldSQS8ULLTX5
 3pav78JzJYUywEIPp5X1QkFFYN/fyD1HbR1LANoFZqE7ZTOGpyOrgHFe5
 7eO38H5eO5fiOT56V1dzH+q+q+u+gMUIopFXf5z8sGUG6KshZpyzmvFZ+
 7bpO8gHSCsQBAYHCr4cnHb7BEb17SGQgCMDmzCy0Mnowwk/VY7X5+c2su
 IVr/73e34MnmpI0cvidZXpybJwSwAynViqyRuoXXoAH1DjNq2X4ykut/w
 7lcuNll69H0Qr2KITfePsMcg+6pKSKbguO9APv3uBIIe+MIYWngVp4CHs Q==;
Date: Wed, 1 Apr 2020 18:12:48 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200401161247.c6jts3nmeru5foex@soft-dev3.microsemi.net>
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
 <15dcc261-bcbb-ec67-2d8d-4208dda45b86@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <15dcc261-bcbb-ec67-2d8d-4208dda45b86@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next v4 0/9] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

The 03/30/2020 19:21, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 27/03/2020 11:21, Horatiu Vultur wrote:
> > Media Redundancy Protocol is a data network protocol standardized by
> > International Electrotechnical Commission as IEC 62439-2. It allows rings of
> > Ethernet switches to overcome any single failure with recovery time faster than
> > STP. It is primarily used in Industrial Ethernet applications.
> >
> > Based on the previous RFC[1][2][3], the MRP state machine and all the timers
> > were moved to userspace, except for the timers used to generate MRP Test frames.
> > In this way the userspace doesn't know and should not know if the HW or the
> > kernel will generate the MRP Test frames. The following changes were added to
> > the bridge to support the MRP:
> > - the existing netlink interface was extended with MRP support,
> > - allow to detect when a MRP frame was received on a MRP ring port
> > - allow MRP instance to forward/terminate MRP frames
> > - generate MRP Test frames in case the HW doesn't have support for this
> >
> > To be able to offload MRP support to HW, the switchdev API  was extend.
> >
> > With these changes the userspace doesn't do the following because already the
> > kernel/HW will do:
> > - doesn't need to forward/terminate MRP frames
> > - doesn't need to generate MRP Test frames
> > - doesn't need to detect when the ring is open/closed.
> >
> > The userspace application that is using the new netlink can be found here[4].
> >
> 
> Hi Horatiu,

Hi Nik,

> One issue in general - some functions are used before they're defined (the switchdev
> API integration ones) patch 4 vs 7 which doesn't make sense. Also I see that the BRIDGE_MRP is used
> (ifdef) before it's added to the Kconfig which doesn't make much sense either.
> I think you should rearrange the patches and maybe combine some of them.

Thanks for the feedback, in the next patch series I will make sure that
everything is defined before it is used.


> 
> Thanks,
>  Nik
> 

-- 
/Horatiu
