Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E66A8402B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DE6D84020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=c2k9Gs9aq7wD8Q/GIeDAjL6HQrb7wXOBzG+CfyfPzhY=;
 b=ACF8TqJG/PCVXLN/DfmbuzxuxGjPaw8maXBAuewHlJ9tumjTSGSDkhS2sVl3mLiHWH
 gCsWXSI0FmZsI34OPo09XlR6d0q73kcocEcWWkKGjzE3a/SnNxwefEu0fWJe685Ee1bh
 hr76tigPIOAmzmWMQbOcJl98m4kLXsEmHlFrh8NsMF6Wgk180kD1qEg0trdSvLAXMwBy
 m3yuAKekMn8UkwpXDJcG2Vu9OTQUQp0DWYtTLeXC54pTyG2QSdPeVLqWSbJ9mZD+WR0E
 Kn3/kl+f8xFbpe2MgcBwchwQdpRzPAIdytrWqM4CVkxx1m25gChgQcEbUAhWaqWj8AxP
 RQNg==
Date: Thu, 21 Jul 2022 14:54:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220721115447.cxfiromwtxw4ukv4@skbuf>
References: <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <20220717125718.mj7b3j3jmltu6gm5@skbuf>
 <a6ec816279b282a4ea72252a7400d5b3@kapio-technology.com>
 <20220717135951.ho4raw3bzwlgixpb@skbuf>
 <e1c1e7c114f0226b116d9549cea8e7a9@kapio-technology.com>
 <20220717150821.ehgtbnh6kmcbmx6u@skbuf>
 <480c7e1e9faa207f37258d8e1b955adc@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480c7e1e9faa207f37258d8e1b955adc@kapio-technology.com>
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

On Sun, Jul 17, 2022 at 06:10:22PM +0200, netdev@kapio-technology.com wrote:
> Okay, I see the problem you refer to. I think that we have to accept some
> limitations unless you think that just zeroing the specific port bit in the
> DPV would be a better solution, and there wouldn't be caveats with that
> besides having to do a FDB search etc to get the correct DPV if I am not too
> mistaken.

No, honestly I believe that what we should do to improve the limitation
is to have proper ATU database separation between one VLAN-unaware
bridge and another (i.e. what is now MV88E6XXX_FID_BRIDGED to be one FID
per bridge).
