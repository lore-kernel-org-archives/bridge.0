Date: Tue, 11 Sep 2007 15:25:57 +0200
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] bridge int MAC Address
Message-ID: <20070911152557.2a4614fe@oldman>
In-Reply-To: <672655.39736.qm@web52704.mail.re2.yahoo.com>
References: <672655.39736.qm@web52704.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: y varun <varunreddy_y@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 11 Sep 2007 06:09:04 -0700 (PDT)
y varun <varunreddy_y@yahoo.com> wrote:

> Is there any way to change the MAC address of the
> Bridge interface. It normally takes the lowest MAC of
> all the interfaces added to the bridge.
> 
> Any help Appreciated.
> 
> Regards,
> Varun

With recent kernels, you can reset the device address.
Add all the devices, then set the device address with ifconfig or ip link
