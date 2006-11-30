Date: Wed, 29 Nov 2006 17:14:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061129171420.3d45ed78@freekitty>
In-Reply-To: <587BB495FD172F43931DE54C0AFD218616F9FF@reset6.ad2.felines.org>
References: <587BB495FD172F43931DE54C0AFD218616F9FF@reset6.ad2.felines.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] recent crashes? Linux kernel 2.6.18-1.2239.fc5 (Linux
 Fedora Core 5)
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jay Libove <libove@felines.org>
Cc: bridge@lists.osdl.org

On Wed, 29 Nov 2006 19:29:17 -0500
"Jay Libove" <libove@felines.org> wrote:

> Recently, possibly since the most recent one or two kernel upgrades in
> Linux Fedora Core 5, my system has been crashing with a kernel panic.
> The panic prevents anything useful from being written to any log files,
> but on the crash trace left on the screen each time I always see
> something which looks like it is in the bridge code.
> 

If it is a server, please capture the console log during the panic output,
then developers can analyze it.

Ways of doing that are (in order of usefulness):

1. Serial console - most reliable
2. Camera picture with digital camera.  Problem is screen resolution limits
   the amount of info. Also not easy to get a good picture
3. Netconsole. Problem is that for networking bugs, the panic output
   may never make it out.


-- 
Stephen Hemminger <shemminger@osdl.org>
