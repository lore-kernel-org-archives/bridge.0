Date: Tue, 27 Jul 2004 10:01:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Enslaving NICs with kernel commandline parameters?
Message-Id: <20040727100111.46d20460@dell_ss3.pdx.osdl.net>
In-Reply-To: <1188.80.133.184.110.1090089064.squirrel@80.133.184.110>
References: <1188.80.133.184.110.1090089064.squirrel@80.133.184.110>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Rene Bartsch <ML@Bartschnet.de>
Cc: bridge@lists.osdl.org

On Sat, 17 Jul 2004 20:31:04 +0200 (CEST)
"Rene Bartsch" <ML@Bartschnet.de> wrote:

> Hi,
> 
> I need to have a bidge up and running before I can access user-space to
> run brctl.
> 
> Is there any way to enslave NICs by using kernel parameters in boot-manager?

No. but you could set it up either off of a script run by init, or a small
program that did what you want then exec'd init and use kernel parameter init=/bin/mysetup

