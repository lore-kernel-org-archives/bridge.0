Date: Thu, 21 Dec 2006 08:35:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061221083528.27453aec@localhost.localdomain>
In-Reply-To: <BAY131-F189BCD10BF91CCCA569648E2CE0@phx.gbl>
References: <BAY131-F189BCD10BF91CCCA569648E2CE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Cross compiling bridge utils 1.2
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: saravanan chanemouganandam <saravanan_sprt@hotmail.com>
Cc: bridge@lists.osdl.org

On Thu, 21 Dec 2006 14:58:06 +0530
"saravanan chanemouganandam" <saravanan_sprt@hotmail.com> wrote:

> Hi everybody,
>  
> I am a newbie in using bridge utils for my application. I have a problem in cross compiling bridge utils on my host x86 development for my target ARM board. I have recently downloaded bridge utils 1.2 version and fascing some compilation porblem. Can anyone tell me how can I cross compile ?
> I tried using autoconf and ./configure but got some error messages like undefined macro AC_CONFIG_HEADERS (libbridge/configh.h) and can not find sources .in or .. and make throws No more target specified etc.
>  
> Sample autoconf and ./configure and make for arm target would be very helpful .
>  
> Thanks
> Sara

If cross compiling, I wouldn't bother trying to make autoconf work.
Just use configure to setup a local (non-cross) build, then hand edit
the Makefiles.  Autoconf is one of those black art tool sets that
changes a lot between versions and platforms, it probably can do it
but getting it to work would be a pain.
