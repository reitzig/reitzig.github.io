---
  title: Lazy Deserialization in Java
  tags: Programming
---

While coding away on our master's project, my team and I faced a problem. In our setting, users provide Java byte code to a client application which instruments it and passes the resulting JAR archive to remote servers via RMI. The servers execute this code in separate processes and feed it inputs values fetched from the client, again via RMI. Now, this can be a problem as users may provide their own implementations for those input values. Both client and separately started processes have, of course, access to these implementations, but servers may not.

The solution intended by Sun back then is to set up a code repository servers can access and download the necessary code from. We considered this overkill given that the server does not even care about the value[^1]: after RMI deserializes the input, we immediately serialize it again and pass it directly to its child process. Dynamically loading all classes from the archive at hand felt messy for the same reasons.

So we came up with this pattern which I call *lazy deserialization*:

~~~java
import org.apache.commons.lang.SerializationUtils;

class Value<T extends Serializable> implements Serializable {
  private final byte[] data;
  private transient T value;

  Value(T value) {
    this.value = value;
    this.data = SerializationUtils.serialize(value);
  }

  T get() {
    if ( this.value == null ) {
      this.value = (T)SerializationUtils.deserialize(this.data);
    }

    return this.value;
  }
}
~~~

As long as servers do not access the wrapped value, everything is fine; as far as they are concerned, they are passing around dressed-up arrays of bytes. In our case, we added several primitive---and therefore trivially serializable---members of the wrapped value to this class in order to enable the server to be able to report back certain things.

I think this pattern can be of use in any situation that involves passing around serialized objects only some nodes are interested in. After all, you might want to avoid deserializing even if you have access to all necessary class files; after all, (de)serializing can take up quite some time you might want to see better spent.

<sub>Originally posted on [lmazy.verrech.net](http://lmazy.verrech.net/2011/09/lazy-deserialization-in-java/).</sub>

---

[^1]: Especially so as we have a many-to-many relation between  clients and servers, that means many repositories and many loaded  classes you do not need.
