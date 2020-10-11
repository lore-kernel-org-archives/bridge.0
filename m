Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fxGXbZ4rR3KKATBoIOvT5Bak7Llr7/4+tSdJ99Kd1/I=;
 b=vR2tB5CJHdjucZ7zY+9a/U7vQTK4GmhNLfBcXmfL2y1AUPIM6P/Ym55FGeMknQLLl4
 L4ksW3b5iTYcU/1P7j9HhnYtY1JNZjw2ve7gwkxRakdciGIibwq+hCJeglHVAevgYvt9
 mMB7ZRNDGU1VQS4DNzx1qgWgGKh1MJpGRFsT2U4HY7bvfe0XW0wC+ZZ4AOBakX2SwbJy
 1GKeS1ngNe8F1pka0ROx60/QpLrQpsl0SVSlL/8txvDVzChEj4NDMLyCyqF3RNaF/U7o
 11pNNeHoMuI0SiGKBiH9183giapE7dUdewbP1kN0il2Yszl0B3I4Oktz/cN2+INnvkyk
 Zobw==
Date: Sun, 11 Oct 2020 23:15:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20201011201534.ybeb4foumck4bpmw@skbuf>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <4c7b9a8d-caa2-52dd-8973-10f4e2892dd6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7b9a8d-caa2-52dd-8973-10f4e2892dd6@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 08/12] net: dsa: use new function
 dev_fetch_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, David Miller <davem@davemloft.net>, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>

On Sun, Oct 11, 2020 at 09:41:27PM +0200, Heiner Kallweit wrote:
> Simplify the code by using new function dev_fetch_sw_netstats().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Tested-by: Vladimir Oltean <olteanv@gmail.com>
