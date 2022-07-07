Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77520610E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A11186112F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tle9jlf1XL+CuKZZCKk8/9Xh9QpHZZM5Qn39ORyOqj4=;
 b=f06mxs48qNo4rSKbN9MgCRF0G3k3lDnx3IsusDP4IZ7GASvreoRNWd3xTCTmWoPeoU
 /gZ7vU45VNaeCyHoSim28POqn2+9UMEejuJXE2rDpoO3BBZnenj6N8Ch1TN1a9KTzHrq
 WLQSdADneb+yfI4Bry0BKQ3UOj/Xvb5DunTMwTyevS9B9mBTjBisvr6EzjwfmOt8rgE1
 t3zOfArQqKVYOGF3UhyKhYebeDPefM4ihtSYKH7+HlKdExdm+L3JhgNqdTmBkf+oNSHN
 1UyMtjFYDD5m0JaREqHui5mbcpxVsEpuM6XarcPfuA6oc64XqrG2Gw6JuN+glp+ajAFx
 OQPg==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <20220706085559.oyvzijcikivemfkg@skbuf>
 <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
 <20220706143339.iuwi23ktk53ihhb6@skbuf>
 <CAKUejP6NG_X-Bh_xeA2y4Wru2=pxgHaRMdsvMu8NATNxPVeQ7A@mail.gmail.com>
In-Reply-To: <CAKUejP6NG_X-Bh_xeA2y4Wru2=pxgHaRMdsvMu8NATNxPVeQ7A@mail.gmail.com>
From: Hans S <schultz.hans@gmail.com>
Date: Thu, 7 Jul 2022 08:54:57 +0200
Message-ID: <CAKUejP6wfcCE9n=_i2vroNX+v1YdGJzOH0bev06nrUCOsRPdwQ@mail.gmail.com>
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

Hi Vladimir,

BTW, I have sent the patch to read the FID as you requested. You
should have received it yesterday (6th July) at around 12:25 UTC.

Hans
