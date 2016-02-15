Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 15 Feb 2016 03:10:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160215021044.GB3138@otheros>
References: <56A2993B.4070307@gmail.com> <20160122131046.6f141681@xeon-e3>
	<56A2AF73.2090204@gmail.com> <20160213023528.GC7093@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160213023528.GC7093@otheros>
Subject: Re: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sat, Feb 13, 2016 at 03:35:28AM +0100, Linus Lüssing wrote:
> PS: 4.4.0 did not have c2d4fb yet, that was added with 4.4.1. While
> missing it does cause trouble, it should not cause a csum error.

Just for the record: I was wrong here, that patch was part of v4.4
already and even v4.3.
