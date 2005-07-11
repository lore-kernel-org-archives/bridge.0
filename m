Date: Mon, 11 Jul 2005 10:20:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] new ioctl
Message-ID: <20050711102044.29f2a5ef@dxpl.pdx.osdl.net>
In-Reply-To: <42D2250A.5090105@smartbridges.com>
References: <42D2250A.5090105@smartbridges.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: munro <munro.biswal@smartbridges.com>
Cc: bridge@lists.osdl.org

On Mon, 11 Jul 2005 15:51:38 +0800
munro <munro.biswal@smartbridges.com> wrote:

> Hi, all,
> 
> I am a newbie. i wish to add another ioctl into brctl for doing some 
> manipulations. How do i do so??
> 
> Please advise on the steps.
> 

I moved away from using ioctl's for doing bridge stuff and used 
sysfs instead for the newer API's in 2.6. The problem was that
it is impossible to to use device private ioctl's in a mixed
32bit/64bit environment.  If you look at the ioctl translation
code in kernel/compat.c you will see how the bridge specific
ioctl's are translated.  But the SIOCDEVPRIVATE one's couldn't
easily be fixed.
