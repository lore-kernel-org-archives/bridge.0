Date: Mon, 4 Apr 2005 09:30:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050404093036.1065a465@dxpl.pdx.osdl.net>
In-Reply-To: <20050404162201.GA10070@nihil>
References: <20050327092700.GA19972@nihil>
	<20050329112733.GA6274@darkalpt.hinezumilabs.org>
	<20050404162201.GA10070@nihil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH bridge-2.6.11] bridge hub_enabled option
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alpt <alpt@freaknet.org>
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com, bridge@lists.osdl.org

On Mon, 4 Apr 2005 18:22:01 +0200
Alpt <alpt@freaknet.org> wrote:

> On Tue, Mar 29, 2005 at 01:27:33PM +0200, Alpt wrote  :
> ~> The document describing this patch is here:
> ~> http://www.freaknet.org/alpt/src/bridge-hub/readme
> ~> 
> ~> There is a small correction for this patch. The new version is attached
> ~> here and be be found also here:
> ~> http://www.freaknet.org/alpt/src/bridge-hub/bridge-2.6.11-hub.patch
> ~> 
> ~> The patch for the bridge-utils:
> ~> http://www.freaknet.org/alpt/src/bridge-hub/bridge-utils-1.0.6-hub.patch
> 
> so.. is it applied or not?
> 
> Best Regards

I would rather it not be applied to mainline since it only has specialized usage.
I am willing to hold keep it in the patches area of the bridge site so others
can find it.
