Date: Fri, 22 Apr 2005 11:45:31 +1000
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Enable Bridgeing with a unsupported Eth devices
Message-ID: <20050422114531.3568540c@localhost.localdomain>
In-Reply-To: <42678038.5070404@au-kbc.org>
References: <42678038.5070404@au-kbc.org>
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
To: bharathi@au-kbc.org
Cc: bridge@lists.osdl.org

On Thu, 21 Apr 2005 15:58:08 +0530
bharathi <bharathi@au-kbc.org> wrote:

> Hi All,
>               What should I do if  I need  to enable bridging in 
> unsupported adaptec  ANA7711F fiber Ethernet cards. What should i do 
> with the kernel
> bridge source. Plz give me some  pointers.
> 
> Thanks,
> bharthix.
> http://bharthix.tk/

You need to get/build/find a ethernet device driver. Bridging expects
the device to look like a ethernet device and interfaces with it.
There is a linux driver on adaptec's web site but it is a huge TOE type device
and probably won't work for bridging.  TOE is crap
