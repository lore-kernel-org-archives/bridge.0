Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F2B141972
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 074744196C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G4esfYTxHELQd8ei6tadwaUmwXAofdum1wcfAogHWU=;
 b=UNz3qqV/oXl3P3J4mgCzuv2XV2Iy9n8SHRPgEcllHDj078gOKXy7JPMI6Xm0jeoAS4j8nNY4nuyK3iXx+DDhPInqYFjC39ymIO/eYhXsf0PQ8kZKZVw9tj1lboLHrkIJnvBjAuhJjZ9ZjZ5qHAisg5U39klpFNt8XwPLRgU/ocB1di43mLGyCRLBhvCzS8ZY2k8Fg6wsFyTVzcqfSFFLVwHXqCUw9t2FW8uLSkUBaL+Ee5XI+67CE9T1KmnNDBBqMQxraiBD+zNkWBetjwAmOr6cidQYKdf2CpFp3pPpeBWQMNzVHMK0c3zpSNigg980pqVbQTPhwEpnjrojDC9MHA==
Date: Wed, 17 Aug 2022 09:21:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YvyI+NrYOXAJHzQZ@shredder>
References: <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <79683d9cf122e22b66b5da3bbbb0ee1f@kapio-technology.com>
 <YvIm+OvXvxbH6POv@shredder>
 <6c6fe135ce7b5b118289dc370135b0d3@kapio-technology.com>
 <YvNcitNnyFxTw8bs@shredder>
 <a1fc2c378816489e15995eb481c318eb@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1fc2c378816489e15995eb481c318eb@kapio-technology.com>
MIME-Version: 1.0
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Tue, Aug 16, 2022 at 09:51:32AM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-10 09:21, Ido Schimmel wrote:
> > > >
> > > > 1. It discards packets with matching DMAC, regardless of ingress port. I
> > > > read the document [1] you linked to in a different reply and could not
> > > > find anything against this approach, so this might be fine or at least
> > > > not very significant.
> > > >
> > > > Note that this means that "locked" entries need to be notified to device
> > > > drivers so that they will install a matching entry in the HW FDB.
> > > 
> 
> I just want to be completely sure as what should be done in version 5 with
> locked entries from the bridge, as - if I should implement it so that they
> are sent to all the drivers, and the drivers then ignore them if they don't
> need to take action? (for the mv88e6xxx driver, it does not need them and
> can ignore but other drivers might need.)

Yes, I think that would be best. At least when mlxsw starts supporting
MAB it will need to program the locked entry as an FDB with discard
action.

To be clear, I'm aware that all drivers other than mv88e6xxx currently
forbid a port from being locked, making it unlikely that they will
receive such notifications, but if you do it now then we will not need
more changes in the bridge when other drivers gain support for
802.1X/MAB.
