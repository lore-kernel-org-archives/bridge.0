Date: Fri, 19 Nov 2004 09:31:30 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] brctl returns 0 on error
Message-Id: <20041119093130.2aae3f45@zqx3.pdx.osdl.net>
In-Reply-To: <419E0362.7030400@core.gen.tr>
References: <419E0362.7030400@core.gen.tr>
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
To: Aycan iRiCAN <aycan@core.gen.tr>
Cc: bridge@osdl.org

On Fri, 19 Nov 2004 16:29:54 +0200
Aycan iRiCAN <aycan@core.gen.tr> wrote:

> Hi,
> 
> "brctl" returns 0 when trying to delete non-existent bridge. If it 
> returns 0, scripting will be an headache. It should return different than 0.
> 
> # brctl delbr geek
> bridge geek doesn't exist; can't delete it
>

That is true for old versions of the bridge utilities.

