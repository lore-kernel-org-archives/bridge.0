Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JlSDTrMLCmc5n2ZJdwjUCSRTD54RzeM/4/q2sdv25jo=;
 b=c6sWo3xXkqmXwk4zqCMnEhspLRrdVlstTAEwqW5ADtJsxzmXRVvGDhHJwNbvm3L1GE
 cBePNIqauQpE2mLrOvmuh2DzSlaizlX28lqEJOuJnCB3essSkUsssjlTc5I9j+YdI+ML
 ah9cynpMusdLJTPHlaTrCjPCYdY4CKrxFigK4vTd4zcrcugtT/SqBM34cceNXtEn3Cmh
 n2qX3+Ebtdw7/Fl64N/gScs0ozHSk6Lrnvpjna19n/oGwvzO8M7wFa8UOop1wQBkqki2
 qujVIXmhyeVE09+4HeePt8Jvw2HQPA7w1UJ5QKLijFRNTqrPN3KOcFQqDIlsIa5f10Kc
 oC7Q==
Message-ID: <f9b3ecf5-c2a4-3a7a-5d19-1dbeae5acb69@gmail.com>
Date: Wed, 16 Mar 2022 17:18:30 -0700
MIME-Version: 1.0
Content-Language: en-US
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] Extend locked port feature with
 FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>



On 3/10/2022 6:23 AM, Hans Schultz wrote:
> This patch set extends the locked port feature for devices
> that are behind a locked port, but do not have the ability to
> authorize themselves as a supplicant using IEEE 802.1X.
> Such devices can be printers, meters or anything related to
> fixed installations. Instead of 802.1X authorization, devices
> can get access based on their MAC addresses being whitelisted.
> 
> For an authorization daemon to detect that a device is trying
> to get access through a locked port, the bridge will add the
> MAC address of the device to the FDB with a locked flag to it.
> Thus the authorization daemon can catch the FDB add event and
> check if the MAC address is in the whitelist and if so replace
> the FDB entry without the locked flag enabled, and thus open
> the port for the device.
> 
> This feature is known as MAC-Auth or MAC Authentication Bypass
> (MAB) in Cisco terminology, where the full MAB concept involves
> additional Cisco infrastructure for authorization. There is no
> real authentication process, as the MAC address of the device
> is the only input the authorization daemon, in the general
> case, has to base the decision if to unlock the port or not.
> 
> With this patch set, an implementation of the offloaded case is
> supplied for the mv88e6xxx driver. When a packet ingresses on
> a locked port, an ATU miss violation event will occur. When
> handling such ATU miss violation interrupts, the MAC address of
> the device is added to the FDB with a zero destination port
> vector (DPV) and the MAC address is communicated through the
> switchdev layer to the bridge, so that a FDB entry with the
> locked flag enabled can be added.

FWIW, we may have about a 30% - 70% split between switches that will 
signal ATU violations over a side band interrupt, like mv88e6xxx will, 
and the rest will likely signal such events via the proprietary tag format.
-- 
Florian
