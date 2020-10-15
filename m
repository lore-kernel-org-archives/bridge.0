Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761276; x=1634297276;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k9yQOQDUXV3I2m/wrCWuOI9bnOjBykltesKYm7FGj/s=;
 b=gynivXkWrvmulGvao/5hdAduBP5V4YhwPNBsolKKcffmGpFSOLAYGiY7
 vyNvv8UMeqF1PkIfYH4R97nl/5XUbor+yHGYwgZA1O3kTWFlTPrNLSMMe
 SUFQcT+pOCkWX7P/MPeuJmmgku+MKUv4i41uCJMmefqLnN4+pZIpwcplt
 dnAKPk5KUF/gIROw7ec6AyZwMEV4dkjR+QjmWvA5T3UQDm5X2EeRL7lrS
 rhtrntMZQHRpY7DC77SaGMe1fkZ7TVgWEBvxqzzHKc7qyJW29CvZz4wF2
 QE9XEmrpwDAm5oKrYToBNBeZZtRXitxRGtkxXLAauF9OAcWNWIsJfvnue w==;
Date: Thu, 15 Oct 2020 11:26:14 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112614.zppuogx6j44ldqh6@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
 <20201014163018.0c2a4fc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014163018.0c2a4fc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 04/10] bridge: cfm: Kernel space
 implementation of CFM. MEP create/delete.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for your review. Comments below.
Regards
Henrik

The 10/14/2020 16:30, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:22 +0000 Henrik Bjoernlund wrote:
> > +     if (config->mdlevel > 7) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "MD level is invalid");
> > +             return -EINVAL;
> > +     }
> > +     /* The MEP-ID is a 13 bit field in the CCM PDU identifying the MEP */
> > +     if (config->mepid > 0x1FFF) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "MEP-ID is invalid");
> > +             return -EINVAL;
> > +     }
> 
> If I'm reading patch 7 correctly these parameters come from netlink,
> right? In that case please use the netlink policies to check things
> like ranges or correct values.

I have changed as requested.

-- 
/Henrik
