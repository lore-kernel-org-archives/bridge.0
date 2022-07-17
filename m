Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A426E83EE3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F8D583EE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jMRTq+amxNbsBbaOEm6j4FB9NZ1ewtvtmU0mvf4Nm0M=;
 b=IOfVoC11XaS/bWBvLr7Vh11vHQNhwzU0vVkGdNo3Legzm2DOd3dsW/pf8Rh9UjPWvX
 JuW4lEESZ/2apkqE1vo/b/0jvOg/Jf4+7VMt8UaL99wPJ+sn56IuX483kWkcZN3oyoVm
 XToQ4LXI+rik0Y+WztVuU70lo5i92MQulNSXG7vji4vHLtK/VwnrCQx63blturHmJvML
 cdzmEn1GlbHtzRPNw4I/rTk14965Bq/tNQPmfHAUuE5JyL3ItbnQrRJuMi9apyDejczM
 I9t/HENKdlD8vqV7gjUbiCQrU9DiPG1mqk0a1iu25lYshFwxl9SoPiX/JQwBuvT5557j
 EhWA==
Date: Sun, 17 Jul 2022 17:03:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220717140325.p5ox5mhqedbyyiz4@skbuf>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <20220717134610.k3nw6mam256yxj37@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717134610.k3nw6mam256yxj37@skbuf>
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 04:46:10PM +0300, Vladimir Oltean wrote:
> Here, what happens is that a locked port learns the MAC SA from the
> traffic it didn't drop, i.e. link-local. In other words, the bridge
> behaves as expected and instructed: +locked +learning will cause just
> that. It's the administrator's fault for not disabling learning.
> It's also the mv88e6xxx driver's fault for not validating the "locked" +
> "learning" brport flag *combination* until it properly supports "+locked
> +learning" (the feature you are currently working on).
> 
> I'm still confused why we don't just say that "+locked -learning" means
> plain 802.1X, "+locked +learning" means MAB where we learn locked FDB entries.

Or is it the problem that a "+locked +learning" bridge port will learn
MAC SA from link-local traffic, but it will create FDB entries without
the locked flag while doing so? The mv88e6xxx driver should react to the
'locked' flag from both directions (ADD_TO_DEVICE too, not just ADD_TO_BRIDGE).
