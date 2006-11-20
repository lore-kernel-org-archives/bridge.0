Message-ID: <82b0add70611201515i4831f77eh8d119966f5793304@mail.gmail.com>
Date: Mon, 20 Nov 2006 18:15:22 -0500
From: "Joubert Berger" <joubertb@gmail.com>
Sender: joubert@berger-family.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] setting STP values via brctl
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have been playing around with the STP settings of brctl and saw
something strange.

I was setting the hello time, so I executed the following:

# brctl sethello br0 30

Then I had a look at the value that was set:

# cat /sys/class/net/br0/bridge/hello_time
2999

Much bigger than expected.

I started looking at the source.  In the libbridge/libbridge_devif.c
file of brctl, we have the following routine:

int br_set_bridge_hello_time(const char *br, struct timeval *tv)
{
        return br_set(br, "hello_time", __tv_to_jiffies(tv),
                      BRCTL_SET_BRIDGE_HELLO_TIME);
}

Note the tv_to_jiffies() call.

Then, I looked in the kernel file linux/net/bridge/br_sysfs_br.c at
the following function:

static void set_hello_time(struct net_bridge *br, unsigned long val)
{
        unsigned long t = clock_t_to_jiffies(val);
        br->hello_time = t;
        if (br_is_root_bridge(br))
                br->bridge_hello_time = t;
}

Note the clock_t_to_jiffies() call.

Are we converting the time in brctl to jiffies and then when it enters
the kernel, we again change the value again to jiffies?

Or have I misses something completely?

--joubert
