Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37228826FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 606D38261C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mgLijbGiv7w5WcB394gTGKOAZY0RuPs+Rksu0EAHhP0=;
 b=PoKHZYvWz8UNSDm7/4be0e1yTfsfKdrINSRSDucpfsLdJhGiMe4Dy8Fn79y/ZFH8ed
 EtXbgx7l8oqOdp8GQsG/GP9cnFhttUWrNJAqgGdnx+vhlqmVU8TA4ygdTMptBJjhOgmd
 lDDnH/VhLQVViWoTa4CfM3Lr9AhmExeui8ZeEV+P105VN7GEQQID9i7OV7a3YKX7ki6m
 ZjUPEkHwwBJguriMDYvvbafm4iqlpbwT+zv9w3M+YviR6xccU7wADVRHY9qF40xSwXhR
 arbZHnCKSdVkhy+d2Y33ulgxl9QDO/zinDGBVgYW7DogjO8frZpZ8JYSFDMtHLsLhDfj
 5Pcw==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
In-Reply-To: <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
From: Hans S <schultz.hans@gmail.com>
Date: Tue, 5 Jul 2022 17:05:52 +0200
Message-ID: <CAKUejP5u9rrH8tODODG0a1PLXfLhk7NLe5LUYkefkbs15uU=BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
	mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Hi, does anybody know what it going on with this variable?
struct dsa_port *dp ->ageing_time;

I experience that it changes value like a factor ~10 at times.
