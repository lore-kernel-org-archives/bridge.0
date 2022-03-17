Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=0LIMf2wAtLBEAi/57yWN7rM87seWRRBpgZ91TFWXDsc=;
 b=Ct1jRFK9QSNtX/UHfG54ye6ymLlehHvfGhaxcp4KotK30E4V7fGxxSRW2iMJ8nJWjr
 IX95NN9TNTnCKufsm5+m49eAxrXJSLQ4qH7fpRbR85s03bwOaGnm+mbCZx+tOVKWPqiV
 PP3yRghqAVBGHCYKL2iX9KS3xZQuFj8g3FPbgrtiMY91HvdR5F9SOQIWs9oSgDdlw754
 4Q64Pb4sF5dcuT5B4f2z4x/4MUOM5YegzVCLc34FAg65vxYm67s7hmCfNI6Pqp8p8u9J
 2dr+VmwRn2HltCf2aFgEYrTuZNArDMjdDEvTM9dM3VbDgWyVO7Lw/1bf+Rw5gWfyc0Fz
 j/mA==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <f9b3ecf5-c2a4-3a7a-5d19-1dbeae5acb69@gmail.com>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <f9b3ecf5-c2a4-3a7a-5d19-1dbeae5acb69@gmail.com>
Date: Thu, 17 Mar 2022 09:29:10 +0100
Message-ID: <86o825htih.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Florian Fainelli <f.fainelli@gmail.com>, Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On ons, mar 16, 2022 at 17:18, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 3/10/2022 6:23 AM, Hans Schultz wrote:
>> This patch set extends the locked port feature for devices
>> that are behind a locked port, but do not have the ability to
>> authorize themselves as a supplicant using IEEE 802.1X.
>> Such devices can be printers, meters or anything related to
>> fixed installations. Instead of 802.1X authorization, devices
>> can get access based on their MAC addresses being whitelisted.
>> 
>> For an authorization daemon to detect that a device is trying
>> to get access through a locked port, the bridge will add the
>> MAC address of the device to the FDB with a locked flag to it.
>> Thus the authorization daemon can catch the FDB add event and
>> check if the MAC address is in the whitelist and if so replace
>> the FDB entry without the locked flag enabled, and thus open
>> the port for the device.
>> 
>> This feature is known as MAC-Auth or MAC Authentication Bypass
>> (MAB) in Cisco terminology, where the full MAB concept involves
>> additional Cisco infrastructure for authorization. There is no
>> real authentication process, as the MAC address of the device
>> is the only input the authorization daemon, in the general
>> case, has to base the decision if to unlock the port or not.
>> 
>> With this patch set, an implementation of the offloaded case is
>> supplied for the mv88e6xxx driver. When a packet ingresses on
>> a locked port, an ATU miss violation event will occur. When
>> handling such ATU miss violation interrupts, the MAC address of
>> the device is added to the FDB with a zero destination port
>> vector (DPV) and the MAC address is communicated through the
>> switchdev layer to the bridge, so that a FDB entry with the
>> locked flag enabled can be added.
>
> FWIW, we may have about a 30% - 70% split between switches that will 
> signal ATU violations over a side band interrupt, like mv88e6xxx will, 
> and the rest will likely signal such events via the proprietary tag
> format.

I guess that the proprietary tag scheme a scenario where the packet can
be forwarded to the bridge module's ingress queue on the respective
port?

> -- 
> Florian
