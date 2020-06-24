Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1592998320; x=1624534320;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ytChrvYAloZwmq/t2qRRQKdJIdRvD5ZigkU1TGR2Ylk=;
 b=ZrftBgW6ozx7zi3Ux+ru8fl+eNvNtoBNtq6iKsMOteqPTpTo5hi7xZlz
 vrqtcmyWJkCo5AUPfBzttRWII4A3S/FWub0jOvfrn9nPPpi8guqAuV7U9
 U6gJUgKI/QL3aEHu1Kz+LsnSeAWRepBkaLvYBQEE9La/zODGZiYs7fbUD
 Ke9rZcpv9M9zdU2sPmlr+F/YEpytfQ4pf4sPKj1aVtF7XBbhukQQkLZmW
 94TWwVMHe6BJwEYd9EPQk9IjPJkHRdtGhA5k6ezxHmlwxbWJBr40dEYSQ
 W7g1Q+LtuQiEZDsSqtpCFlxhiWsmVWaDYl6e1rweivGcZeTmx1BcVYbJg A==;
Date: Wed, 24 Jun 2020 13:31:56 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200624113156.hsutqewk4xntmkld@soft-dev3.localdomain>
References: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
 <20200623.143821.491798381160245817.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200623.143821.491798381160245817.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH net v2 0/2] bridge: mrp: Update MRP_PORT_ROLE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

The 06/23/2020 14:38, David Miller wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Horatiu Vultur <horatiu.vultur@microchip.com>
> Date: Tue, 23 Jun 2020 11:05:39 +0200
> 
> > This patch series does the following:
> > - fixes the enum br_mrp_port_role_type. It removes the port role none(0x2)
> >   because this is in conflict with the standard. The standard defines the
> >   interconnect port role as value 0x2.
> > - adds checks regarding current defined port roles: primary(0x0) and
> >   secondary(0x1).
> >
> > v2:
> >  - add the validation code when setting the port role.
> 
> Series applied, thank you.

Thanks. Will these patches be applied also on net-next?
Because if I start now to add support for the interconnect port, these
patches are needed on net-next. Or do I need to add these patches to the
patch series for the interconnect port?
What is the correct way of doing this?

-- 
/Horatiu
