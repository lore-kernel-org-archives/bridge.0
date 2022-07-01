Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C11140AED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68F1D400C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6+9i5SuUEh0ZfHLFomcmco8y7vOn2ICelFhVSEAttY=;
 b=T1xLn7bFguZH0ng3kiPZlm+6qHbEt1sr3eqL+G3tWgBLub0f9wSshlk90F9A4TkZsgqlOO67rmniorp4SNjiYoXC9AT/vwpELoXZ4bAvsFK1vhi48DCRIwFOKtMLBes3aSp/UYIlGscf/VnlaiTXtQAC+MNFzX9jYcTowBm7AYsi/uoTQwtwXPAnRjF4ZgIgybdTEEKU38NL1+RjQs+chdF9j0dA/wC11Foka6McoKCBkcOvE2hgHpC8YwuVtFlsu63dp/C2l2F/q9MRdy4nklJ5MBgsqui5KNCcHRAOS8CtlMpdVA8Z4BHX3JHBdboIH7iZ7JmvwYZD14JWslw3zg==
Date: Fri, 1 Jul 2022 16:51:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yr778K/7L7Wqwws2@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
MIME-Version: 1.0
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Hans Schultz <hans@kapio-technology.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 09:47:24AM +0200, Hans S wrote:
> One question though... wouldn't it be an issue that the mentioned
> option setting is bridge wide, while the patch applies a per-port
> effect?

Why would it be an issue? To me, the bigger issue is changing the
semantics of "locked" in 5.20 compared to previous kernels.

What is even the use case for enabling learning when the port is locked?
In current kernels, only SAs from link local traffic will be learned,
but with this patch, nothing will be learned. So why enable learning in
the first place? As an administrator, I mark a port as "locked" so that
only traffic with SAs that I configured will be allowed. Enabling
learning when the port is locked seems to defeat the purpose?

It would be helpful to explain why mv88e6xxx needs to have learning
enabled in the first place. IIUC, the software bridge can function
correctly with learning disabled. It might be better to solve this in
mv88e6xxx so that user space would not need to enable learning on the SW
bridge and then work around issues caused by it such as learning from
link local traffic.
