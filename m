Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1677C610F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D683360B75
MIME-Version: 1.0
Date: Fri, 08 Jul 2022 11:50:33 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220708091550.2qcu3tyqkhgiudjg@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
Message-ID: <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-08 11:15, Vladimir Oltean wrote:
> When the possibility for it to be true will exist, _all_ switchdev
> drivers will need to be updated to ignore that (mlxsw, cpss, ocelot,
> rocker, prestera, etc etc), not just DSA. And you don't need to
> propagate the is_locked flag to all individual DSA sub-drivers when 
> none
> care about is_locked in the ADD_TO_DEVICE direction, you can just 
> ignore
> within DSA until needed otherwise.
> 

Maybe I have it wrong, but I think that Ido requested me to send it to 
all the drivers, and have them ignore entries with is_locked=true ...
