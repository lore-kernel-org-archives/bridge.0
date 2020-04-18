Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587222242; x=1618758242;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P9QFx2m+EdJ/Sth2lo4BRux+9U5rJNWn4YuJ3jtIOzo=;
 b=Opwic/DtKR4PaGtUgfDQ4B7TZeNMjVTBYxsiK2PgiFXgKuvHosSiIcN1
 48oxBUmCE7oyqDVRgSOQFOA3c+He6Uj/u2IfVg/Wt7aj72cBO7fDJ2IqI
 jUwf7sbhZZJ5ZIlWomHXegvKT5ujp/noIw04FwBVs6Z8mSmDPDhqLyFGA
 IgwKZGoLTrak1G+S4Z01miN24XXNi27kNUv7aPFv0gltC71F84xMog2h4
 y6LAt/PRzKo3NSoNXjPYxX2Q0kNnU0nznBnhfR7rYKktkFvpix/uydxG8
 9/9X96QB8xeYGEI8/3PRNHPZkcUEV+vId11bk62+j9DIE4T5Sz8FrgyAO A==;
Date: Sat, 18 Apr 2020 17:03:59 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200418150359.no4qcgc7oxqunkjp@soft-dev3.microsemi.net>
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <59ccd697-3c97-207e-a89d-f73e594ec7eb@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <59ccd697-3c97-207e-a89d-f73e594ec7eb@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next v5 0/9] net: bridge: mrp: Add support
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

The 04/18/2020 12:01, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 14/04/2020 14:26, Horatiu Vultur wrote:
> > Media Redundancy Protocol is a data network protocol standardized by
> > International Electrotechnical Commission as IEC 62439-2. It allows rings of
> > Ethernet switches to overcome any single failure with recovery time faster than
> > STP. It is primarily used in Industrial Ethernet applications.
> >
> > Based on the previous RFC[1][2][3][4], the MRP state machine and all the timers
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
> 
> Hi Horatiu,
> The set still has a few blocker issues (bisectability, sysfs error return, use of extack)
> and a few other cleanup tasks as I've noted in my replies to the respective patches.
> I think with those out of the way you can submit it for inclusion.

Hi Nik,

Thanks for the review. I really need to be more careful with the
bisectability. I will update the code based on your comments and then
send the patch series again.

> 
> Cheers,
>  Nik
> 
> 
> 
> 

-- 
/Horatiu
