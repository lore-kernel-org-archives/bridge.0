Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ceRQl/rDBk6AZGZV87hR1KyptG7t3Kf+Og5g8l3kQ9Y=;
 b=EGaNa2JDouvflDLK16jMocP/xa7o58nL6cBYI8lu6B771+YtUHoDF+JKGHZXWYU25f
 KemrpG/1oHZ8O9fbqwGH3f2OkmaxKyHDIcY4/YISPKDIHyUhRIwG5eiK5GmNUU2FxDSb
 FXbpCOoCuMcMKElQAFnKuh9tEqSgC3NdDhZI8=
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <15dcc261-bcbb-ec67-2d8d-4208dda45b86@cumulusnetworks.com>
Date: Mon, 30 Mar 2020 19:21:41 +0300
MIME-Version: 1.0
In-Reply-To: <20200327092126.15407-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 27/03/2020 11:21, Horatiu Vultur wrote:
> Media Redundancy Protocol is a data network protocol standardized by
> International Electrotechnical Commission as IEC 62439-2. It allows rings of
> Ethernet switches to overcome any single failure with recovery time faster than
> STP. It is primarily used in Industrial Ethernet applications.
> 
> Based on the previous RFC[1][2][3], the MRP state machine and all the timers
> were moved to userspace, except for the timers used to generate MRP Test frames.
> In this way the userspace doesn't know and should not know if the HW or the
> kernel will generate the MRP Test frames. The following changes were added to
> the bridge to support the MRP:
> - the existing netlink interface was extended with MRP support,
> - allow to detect when a MRP frame was received on a MRP ring port
> - allow MRP instance to forward/terminate MRP frames
> - generate MRP Test frames in case the HW doesn't have support for this
> 
> To be able to offload MRP support to HW, the switchdev API  was extend.
> 
> With these changes the userspace doesn't do the following because already the
> kernel/HW will do:
> - doesn't need to forward/terminate MRP frames
> - doesn't need to generate MRP Test frames
> - doesn't need to detect when the ring is open/closed.
> 
> The userspace application that is using the new netlink can be found here[4].
> 

Hi Horatiu,
One issue in general - some functions are used before they're defined (the switchdev
API integration ones) patch 4 vs 7 which doesn't make sense. Also I see that the BRIDGE_MRP is used
(ifdef) before it's added to the Kconfig which doesn't make much sense either.
I think you should rearrange the patches and maybe combine some of them.

Thanks,
 Nik

