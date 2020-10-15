Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761403; x=1634297403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KQhsyXAMn7AN17uLkcxZ/87dpZXLNz6fwDSYmoiJKHY=;
 b=BxYqeTlg9l0jyp7RBGwaDf+9OoAIfJFlClWJ1Wg2cmfyvKxv8m17HG7Z
 xUv1Ewg7QYALNiVyRJKAayh1glqShxTjgGYV1/9CeXsQOII++FTUcysNF
 LiJgQLZmpaU5jjTsJh1K3dShMiBJSr0i2vUtXgHxZWxDdrbsDwoLCi5n/
 siK4RJ+tR7W2u2Irjp5OI16PLH8Fg2pvBHbyAp+xrEH9d1A6wn8h+wx3D
 sGQuYERSDbcIaeCON8Jd4wLMitBDe+YExDSU1VD9ShzMcHfRLP+91pWg7
 R/YYQXX+L4dr5pMNIn1U1RYmezaNeCzAWKK6hLchN+q5RiaNrNJxvHkg1 g==;
Date: Thu, 15 Oct 2020 11:28:22 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112822.adfl5kpgffgzi3wg@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
 <20201014161610.46dd5785@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014161610.46dd5785@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
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

The 10/14/2020 16:16, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:24 +0000 Henrik Bjoernlund wrote:
> > +struct br_cfm_status_tlv {
> > +     __u8 type;
> > +     __be16 length;
> > +     __u8 value;
> > +};
> 
> This structure is unused (and likely not what you want, since it will
> have 2 1 byte while unless you mark length as __packed).

I have changed as requested.

-- 
/Henrik
