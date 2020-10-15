Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761311; x=1634297311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RcZqIHyhK/ws9zYsOyz4fhzkQgVNjCJZMvGu9SsFGQM=;
 b=F1eyBEaJpvZ7+vhxhrETBNvNrGsHWVasvF1BRKglgpVnA2jM3oeIjosh
 JowHqC4SXBeCzefAITblkoD12q21E/daM6CKfaR0ZM6TF662leQwMcvZz
 GeH4Hflp4bMuxYYRycKRTlPclRZVB7wENH5GsUteRNrrOhIrldfDYmop9
 wjyYczHHDGEhlqPfQC57I5gnTsyuZ2vanebdCl+mM9jQ3uAWYx8R7+OMe
 hvHiVXQOfQH2JuuIav+Rak0pLOpvO/RVV/p+f44NbEgpMdoR2GXkqmMtq
 fmqE/vtGZR/7NO053//hbPPHQsAYP6kstd6TyIzq/ASaZWIQHZEcZzSls w==;
Date: Thu, 15 Oct 2020 11:26:49 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112649.pzx7q6mwjhrxaiha@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
 <20201014160042.4967a702@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014160042.4967a702@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
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

The 10/14/2020 16:00, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:22 +0000 Henrik Bjoernlund wrote:
> > with restricted management access to each other<E2><80><99>s equipment.
> 
> Some Unicode funk in this line?

I have changed as requested.

-- 
/Henrik
