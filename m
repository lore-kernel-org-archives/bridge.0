Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A575E60BBB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED2EE60AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a2m1SZg7h2oHboY4NytPHUqMWEZ4cTDRU1p3Uh7JG+s=;
 b=Epo4QTTd7Rmf98WYXfniuwZVegSEbuoqug8aWUntuRbDRsemnS1wNPmrlHKp5ywF8K
 46o+vGGjdO36dzhhuR119Vy2PL2m0LJDB1OunDXXMiZPUSbv8qLV81aZNz7yURhEKKQV
 qONo5//m4kDf/aZNOBobcaDuHaf47RluHRrFQas0s28JhGbuNoYpTOSykMcLWdI+pWRG
 dj54yl2wf/L0zZ48XsVIaBp0jZTUCy7/VKCZTN/aCdDtbw1QcpC8vqeKb7aXL+lAq35X
 hJaOZ+Tpg7pQUU0olzJuXjIS2UeqGM0OkzI2BkF6boaQTwpjPj5VZHEqHP2T76i0xNWn
 GwUQ==
Date: Thu, 21 Jul 2022 14:59:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220721115935.5ctsbtoojtoxxubi@skbuf>
References: <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <YtQosZV0exwyH6qo@shredder>
 <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sun, Jul 17, 2022 at 05:53:22PM +0200, netdev@kapio-technology.com wrote:
> > 3. What happens to packets with a DA matching the zero-DPV entry, are
> > they also discarded in hardware? If so, here we differ from the bridge
> > driver implementation where such packets will be forwarded according to
> > the locked entry and egress the locked port
> 
> I understand that egress will follow what is setup with regard to UC, MC and
> BC, though I haven't tested that. But no replies will get through of course
> as long as the port hasn't been opened for the iface behind the locked port.

Here, should we be rather fixing the software bridge, if the current
behavior is to forward packets towards locked FDB entries?
