Date: Wed, 13 Aug 2003 12:06:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20030813120616.29b02cb4.shemminger@osdl.org>
In-Reply-To: <3F39A29A.2070009@metavize.com>
References: <3F39A29A.2070009@metavize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: bug: 2.6.0-test2 ethernet bridge kernel panic
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: dmorris <dmorris@metavize.com>
Cc: bridge@osdl.org

On Tue, 12 Aug 2003 19:29:46 -0700
dmorris <dmorris@metavize.com> wrote:

> bug: 2.6.0-test2 ethernet bridge kernel panic
> 
> Sorry if this has already been reported.
> Please email me if I can help, or give any other info.
> It is a consistent panic, and it appeared sometime between 2.5.68(works 
> fine for me except with SMP) and 2.6.0-test2

Can not reproduce it with 2.6.0-test3,  there were a several patches
to bridging to fix state transition bugs, so it is probably already
fixed.

